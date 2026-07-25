![Bash](https://img.shields.io/badge/language-bash-blue)
![Automation](https://img.shields.io/badge/topic-automation-green)
![Monitoring](https://img.shields.io/badge/topic-monitoring-orange)

# Nexus-Courier

## [DE]
\`nexus-courier\` ist ein robustes Bash-Skript, das entwickelt wurde, um Statusberichte, Log-Dateien oder Pipe-Inhalte von Linux-Servern automatisiert p>

### Funktionen
- **Zero-Config-Aufruf:** Einfach \`./nexus-courier.sh\` aufrufen – Empfänger, Betreff und Nachrichtendatei werden direkt im Skript konfiguriert.
- **Stdin-Pipe-Support:** Nimmt Daten direkt per Pipe entgegen (z.B. \`command | nexus-courier.sh\`).
- **Dateianhang:** Optionaler Dateianhang per \`-a\` Schalter (Multipart MIME).
- **Erweiterter Header:** Unterstützung für \`Reply-To\`, \`Cc\` und \`Bcc\`.
- **Robust:** Prüft Abhängigkeiten (\`msmtp\`, \`base64\`) und Konfiguration vor dem Versand.
- **Hilfe:** Integrierte Hilfe mit \`-h\` oder \`--help\`.

### Installation & Setup
1. Stelle sicher, dass \`msmtp\` installiert ist.
2. Konfiguriere die SMTP-Verbindung über \`~/.msmtprc\` (siehe unten).
3. Passe die Variablen direkt im Skript an (\`DEFAULT_RECIPIENT\`, \`FILE_TO_SEND\`, etc.).
4. Setze Ausführungsrechte: \`chmod +x nexus-courier.sh\`

## Konfiguration (.msmtprc & Sicherheit)
Erstelle die Datei \`~/.msmtprc\` und passe sie an deinen SMTP-Anbieter an:

\`\`\`bash
# msmtp Konfiguration - TLS-Tunnel
defaults
auth           on
tls            on
tls_starttls   off
tls_certcheck  on
logfile        ~/.msmtp.log

# Strato Account
account        strato
host           smtp.strato.de
port           465
from           DEINE_EMAIL_ADRESSE
user           DEIN_BENUTZERNAME
passwordeval   cat ~/.msmtp_pw

# Setze Strato als Standard
account default : strato
\`\`\`

**Wichtig:**
1. Schütze die Datei: \`chmod 600 ~/.msmtprc\`

### Benutzung
\`\`\`bash
# Direkt ausführen (nutzt die im Skript definierten Werte)
./nexus-courier.sh

# Alternativ: Empfänger beim Aufruf überschreiben
./nexus-courier.sh ziel@beispiel.de

# Mit zusätzlichem Dateianhang
./nexus-courier.sh -a /pfad/zur/datei.zip

# Per Pipe übergeben (ohne ANSI-Steuerzeichen für saubere Mails)
curl -s http://de.wttr.in/=Berlin?T | ./nexus-courier.sh
\`\`\`

---
# [ENG]
\`nexus-courier\` is a robust bash script designed to automatically send status reports, log files, or piped data from Linux servers via email.

### Features
- **Zero-Config Execution:** Simply run \`./nexus-courier.sh\` – recipient, subject, and message file are pre-configured directly inside the script.
- **Stdin Pipe Support:** Accept data directly via pipe (e.g., \`command | nexus-courier.sh\`).
- **Attachments:** Optional file attachment via \`-a\` flag (Multipart MIME).
- **Extended Headers:** Support for \`Reply-To\`, \`Cc\`, and \`Bcc\`.
- **Robust:** Validates dependencies (\`msmtp\`, \`base64\`) and configuration existence before sending.
- **Help:** Built-in help function via \`-h\` or \`--help\`.

### Installation & Setup
1. Ensure \`msmtp\` is installed.
2. Configure the SMTP connection via \`~/.msmtprc\` (see below).
3. Adjust variables directly within the script (\`DEFAULT_RECIPIENT\`, \`FILE_TO_SEND\`, etc.).
4. Set execution permission: \`chmod +x nexus-courier.sh\`

### Configuration (.msmtprc & Security)
Create the \`~/.msmtprc\` file and adjust it to your SMTP provider:
\`\`\`bash
# msmtp Konfiguration - TLS-Tunnel
defaults
auth           on
tls            on
tls_starttls   off
tls_certcheck  on
logfile        ~/.msmtp.log


# Setze Strato als Standard
account default : strato
\`\`\`

**Important:**
1. Secure the file: \`chmod 600 ~/.msmtprc\`

### Usage
\`\`\`bash
# Direct execution (uses values defined in the script)
./nexus-courier.sh

# Alternatively: Override recipient on the fly
./nexus-courier.sh target@example.com

# With additional attachment
./nexus-courier.sh -a /path/to/file.zip

# Piped input (without ANSI control characters for clean emails)
curl -s http://de.wttr.in/=Berlin?T | ./nexus-courier.sh
\`\`\`




