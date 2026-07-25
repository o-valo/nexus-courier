#!/bin/bash
## Version 1.0.1

# nexus-courier - Automatisierter Mail-Versand
# Konfiguration - Bitte anpassen
DEFAULT_RECIPIENT="DEIN_EMPFAENGER@beispiel.de"
ACCOUNT="dein_account_name"
SUBJECT="Statusbericht von $(hostname)"
FILE_TO_SEND="/home/USER/PFAD/ZU/DEINER/DATEI.log"

# System-Konfiguration
REQUIRED_CMDS=("msmtp" "cat")
MSMTP_CONFIG="$HOME/.msmtprc"

# Hilfe und Abhängigkeits-Check
show_help() {
    echo "Nutzung: $(basename "$0") [EMPFÄNGER]"
    echo ""
    echo "Beschreibung:"
    echo "  Sendet den Inhalt einer definierten Datei per E-Mail via msmtp."
    echo ""
    echo "Abhängigkeiten:"
    echo "  - msmtp muss installiert sein"
    echo "  - ~/.msmtprc muss existieren und korrekt konfiguriert sein"
    echo ""
    echo "Optionen:"
    echo "  [EMPFÄNGER]  Optionale E-Mail-Adresse. Standard: $DEFAULT_RECIPIENT"
    echo "  -h, --help   Zeigt diese Hilfe an"
    exit 0
}

# Prüfe auf fehlende Abhängigkeiten
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Fehler: Abhängigkeit '$cmd' wurde nicht gefunden. Bitte installieren."
        exit 1
    fi
done

# Prüfe, ob die msmtp-Konfiguration existiert
if [ ! -f "$MSMTP_CONFIG" ]; then
    echo "Fehler: Konfigurationsdatei '$MSMTP_CONFIG' nicht gefunden."
    exit 1
fi

# Argumente verarbeiten
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

RECIPIENT=${1:-$DEFAULT_RECIPIENT}

# E-Mail generieren und senden
{
    echo "Subject: $SUBJECT"
    echo "To: $RECIPIENT"
    echo "MIME-Version: 1.0"
    echo "Content-Type: text/plain; charset=utf-8"
    echo ""
    cat "$FILE_TO_SEND"
} | msmtp -a "$ACCOUNT" "$RECIPIENT"

# powerd by ai
#EOF
