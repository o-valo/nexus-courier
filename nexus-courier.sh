#!/bin/bash
## Version 1.1.0

# nexus-courier - Automatisierter Mail-Versand
# Konfiguration - Bitte anpassen
DEFAULT_RECIPIENT="DEIN_EMPFAENGER@beispiel.de"
ACCOUNT="dein_account_name"
SUBJECT="Statusbericht von $(hostname)"

# Optionale erweiterte Header-Felder (leer lassen, wenn nicht benötigt)
REPLY_TO=""
CC=""
BCC=""

# Konfiguration für Dateien
FILE_TO_SEND="/home/USER/PFAD/ZU/DEINER/NACHRICHT.log"
ATTACHMENT_FILE=""

# System-Konfiguration
REQUIRED_CMDS=("msmtp" "cat" "base64")
MSMTP_CONFIG="$HOME/.msmtprc"

# Hilfe-Funktion
show_help() {
    echo "Nutzung: $(basename "$0") [OPTIONEN] [EMPFÄNGER]"
    echo "         befehl | $(basename "$0") [OPTIONEN] [EMPFÄNGER]"
    echo ""
    echo "Beschreibung:"
    echo "  Sendet den Inhalt der Nachrichtendatei oder von stdin im Mail-Body via msmtp."
    echo "  Optional kann eine separate Datei als echter Dateianhang mitgeschickt werden."
    echo ""
    echo "Optionen:"
    echo "  -a <datei>      Fügt eine separate Datei als MIME-Anhang hinzu"
    echo "  -h, --help      Zeigt diese Hilfe an"
    echo "  [EMPFÄNGER]     Optionale E-Mail-Adresse. Standard: DEINE@MAIL.DE"
    exit 0
}

# Manuelles Argument-Parsing für -h, --help und -a
RECIPIENT=""
CLI_ATTACHMENT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -a)
            if [ -n "${2:-}" ]; then
                CLI_ATTACHMENT="$2"
                shift 2
            else
                echo "Fehler: Option -a erfordert einen Dateipfad." >&2
                exit 1
            fi
            ;;
        -*)
            echo "Unbekannte Option: $1" >&2
            exit 1
            ;;
        *)
            if [ -z "$RECIPIENT" ]; then
                RECIPIENT="$1"
            fi
            shift
            ;;
    esac
done

RECIPIENT=${RECIPIENT:-$DEFAULT_RECIPIENT}

# CLI-Anhang hat Vorrang, ansonsten wird die feste Variable genutzt
ATTACHMENT_FILE="${CLI_ATTACHMENT:-$ATTACHMENT_FILE}"

# Prüfe auf fehlende Abhängigkeiten
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Fehler: Abhängigkeit '$cmd' wurde nicht gefunden." >&2
        exit 1
    fi
done

# Prüfe, ob die msmtp-Konfiguration existiert
if [ ! -f "$MSMTP_CONFIG" ]; then
    echo "Fehler: Konfigurationsdatei '$MSMTP_CONFIG' nicht gefunden." >&2
    exit 1
fi

# Nachrichtentext ermitteln: Entweder von Pipe (stdin) oder aus der konfigurierten Datei
MAIL_BODY=""
if [ ! -t 0 ]; then
    MAIL_BODY=$(cat)
elif [ -f "$FILE_TO_SEND" ]; then
    MAIL_BODY=$(cat "$FILE_TO_SEND")
else
    echo "Fehler: Weder Daten via Pipe (stdin) noch eine gültige Nachrichtendatei ('$FILE_TO_SEND') gefunden." >&2
    exit 1
fi

# E-Mail generieren und senden
TEMP_MAIL=$(mktemp)
trap 'rm -f "$TEMP_MAIL"' EXIT

BOUNDARY="----=_NexusCourierBoundary_$(date +%s%N)"

{
    echo "Subject: $SUBJECT"
    echo "To: $RECIPIENT"
    
    # Optionale Header dynamisch einfügen, falls gesetzt
    [ -n "$REPLY_TO" ] && echo "Reply-To: $REPLY_TO"
    [ -n "$CC" ] && echo "Cc: $CC"
    [ -n "$BCC" ] && echo "Bcc: $BCC"

    echo "MIME-Version: 1.0"

    if [ -n "$ATTACHMENT_FILE" ]; then
        # Modus: Nachricht (stdin/Datei) im Body + separater echter MIME-Anhang
        if [ ! -f "$ATTACHMENT_FILE" ]; then
            echo "Fehler: Anhang-Datei '$ATTACHMENT_FILE' nicht gefunden." >&2
            exit 1
        fi
        
        echo "Content-Type: multipart/mixed; boundary=\"$BOUNDARY\""
        echo ""
        echo "--$BOUNDARY"
        echo "Content-Type: text/plain; charset=utf-8"
        echo "Content-Transfer-Encoding: 8bit"
        echo ""
        echo "$MAIL_BODY"
        echo ""
        echo "--$BOUNDARY"

        FILE_NAME=$(basename "$ATTACHMENT_FILE")
        echo "Content-Type: application/octet-stream; name=\"$FILE_NAME\""
        echo "Content-Transfer-Encoding: base64"
        echo "Content-Disposition: attachment; filename=\"$FILE_NAME\""
        echo ""
        base64 "$ATTACHMENT_FILE"
        echo ""
        echo "--$BOUNDARY--"
    else
        # Reiner Standard-Modus: Nur Nachricht (stdin/Datei) im Textkörper
        echo "Content-Type: text/plain; charset=utf-8"
        echo ""
        echo "$MAIL_BODY"
    fi
} > "$TEMP_MAIL"

msmtp -a "$ACCOUNT" -t < "$TEMP_MAIL"

# powered by ai
#EOF
