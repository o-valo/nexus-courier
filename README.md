![Bash](https://img.shields.io/badge/language-bash-blue)
![Automation](https://img.shields.io/badge/topic-automation-green)
![Monitoring](https://img.shields.io/badge/topic-monitoring-orange)

# Nexus-Courier

## [DE]
`nexus-courier` ist ein robustes Bash-Skript, das entwickelt wurde, um Statusberichte, Log-Dateien oder Pipe-Inhalte von Linux-Servern automatisiert per E-Mail zu versenden.

### Funktionen
- **Zero-Config-Aufruf:** Einfach `./nexus-courier.sh` aufrufen – Empfänger, Betreff und Nachrichtendatei werden direkt im Skript konfiguriert.
- **Dynamischer Betreff:** Überschreiben des Standard-Betreffs per `-s` Schalter.
- **Stdin-Pipe-Support:** Nimmt Daten direkt per Pipe entgegen (z.B. `command | nexus-courier.sh`).
- **Dateianhang:** Optionaler Dateianhang per `-a` Schalter (Multipart MIME).
- **Erweiterter Header:** Unterstützung für `Reply-To`, `Cc` und `Bcc`.
- **Robust:** Prüft Abhängigkeiten (`msmtp`, `base64`) und Konfiguration vor dem Versand.
- **Hilfe:** Integrierte Hilfe mit `-h` oder `--help`.

### Installation & Setup
1. Stelle sicher, dass `msmtp` installiert ist.
2. Passe die Variablen direkt im Skript an (`DEFAULT_RECIPIENT`, `FILE_TO_SEND`, etc.).
3. Setze Ausführungsrechte: `chmod +x nexus-courier.sh`

### Konfiguration (.msmtprc & Sicherheit)
Erstelle die Datei `~/.msmtprc` und passe sie an deinen SMTP-Anbieter an, oder lade die Beispiel-Datei `.msmtprc-example` von GitHub herunter:

```bash
# msmtp Konfiguration - TLS-Tunnel
defaults
auth            on
tls             on
tls_starttls    off
tls_certcheck   on
logfile         ~/.msmtp.log

# Strato Account
account         strato
host            smtp.strato.de
port            465
from            DEINE_EMAIL_ADRESSE
user            DEIN_BENUTZERNAME
passwordeval    cat ~/.msmtp_pw

# Setze Strato als Standard
account default : strato
```

**Wichtig:** Schütze die Konfigurationsdatei vor unbefugtem Zugriff:
```bash
chmod 600 ~/.msmtprc
```

### Benutzung

#### Direkt ausführen (nutzt die im Skript definierten Werte)
```bash
./nexus-courier.sh
```

#### Betreff dynamisch anpassen (`-s`)
```bash
./nexus-courier.sh -s "Individueller Betreff"
```

#### Empfänger beim Aufruf überschreiben
```bash
./nexus-courier.sh ziel@beispiel.de
```

#### Mit benutzerdefiniertem Betreff und Empfänger
```bash
./nexus-courier.sh -s "Wichtige Systemnachricht" ziel@beispiel.de
```

#### Mit zusätzlichem Dateianhang (`-a`)
```bash
./nexus-courier.sh -a /pfad/zur/datei.zip -s "Logfile Anhang" ziel@beispiel.de
```

#### Per Pipe übergeben
```bash
curl -s "wttr.in/Berlin?T" | ./nexus-courier.sh -s "Weather Update"

---

![Bash](https://img.shields.io/badge/language-bash-blue)
![Automation](https://img.shields.io/badge/topic-automation-green)
![Monitoring](https://img.shields.io/badge/topic-monitoring-orange)

## [ENG]
`nexus-courier` is a robust bash script designed to automatically send status reports, log files, or piped data from Linux servers via email.

### Features
- **Zero-Config Execution:** Simply run `./nexus-courier.sh` – recipient, subject, and message file are pre-configured directly inside the script.
- **Dynamic Subject:** Override the default email subject on the fly using the `-s` flag.
- **Stdin Pipe Support:** Accept data directly via pipe (e.g., `command | nexus-courier.sh`).
- **Attachments:** Optional file attachment via `-a` flag (Multipart MIME).
- **Extended Headers:** Support for `Reply-To`, `Cc`, and `Bcc`.
- **Robust:** Validates dependencies (`msmtp`, `base64`) and configuration existence before sending.
- **Help:** Built-in help function via `-h` or `--help`.

### Installation & Setup
1. Ensure `msmtp` is installed.
2. Adjust variables directly within the script (`DEFAULT_RECIPIENT`, `FILE_TO_SEND`, etc.).
3. Set execution permission: `chmod +x nexus-courier.sh`

### Configuration (.msmtprc & Security)
Create the `~/.msmtprc` file and adjust it to your SMTP provider, or download the `.msmtprc-example` file from GitHub:

```bash
# msmtp Configuration - TLS Tunnel
defaults
auth            on
tls             on
tls_starttls    off
tls_certcheck   on
logfile         ~/.msmtp.log

# Strato Account
account         strato
host            smtp.strato.de
port            465
from            YOUR_EMAIL_ADDRESS
user            YOUR_USERNAME
passwordeval    cat ~/.msmtp_pw

# Set Strato as default
account default : strato
```

**Important:** Secure the configuration file:
```bash
chmod 600 ~/.msmtprc
```

### Usage

#### Direct execution (uses values defined in the script)
```bash
./nexus-courier.sh
```

#### Set a custom subject (`-s`)
```bash
./nexus-courier.sh -s "Custom Subject Line"
```

#### Override recipient on the fly
```bash
./nexus-courier.sh target@example.com
```

#### Combine custom subject and recipient
```bash
./nexus-courier.sh -s "Important Notification" target@example.com
```

#### With additional attachment (`-a`)
```bash
./nexus-courier.sh -a /path/to/file.zip -s "Monthly Report" target@example.com
```

#### Piped input
```bash
curl -s "wttr.in/Berlin?T" | ./nexus-courier.sh -s "Weather Update"
```

---

#### Powered with AI
