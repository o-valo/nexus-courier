# Nexus-Courier [DE]

`nexus-courier` ist ein robustes Bash-Skript, das entwickelt wurde, um Statusberichte oder Log-Dateien von Linux-Servern automatisiert per E-Mail zu versenden. Es ist darauf ausgelegt, in komplexen Netzwerkinfrastrukturen als zuverlässiger Bote (Courier) zu fungieren.

## Funktionen
- **Flexibel:** Empfänger kann direkt beim Aufruf als Parameter übergeben werden.
- **Robust:** Prüft Abhängigkeiten (`msmtp`, `cat`) und die Existenz der Konfigurationsdatei vor dem Versand.
- **Dokumentiert:** Eingebaute Hilfe-Funktion (`-h`).
- **Headless-Ready:** Ideal für Ubuntu Server-Umgebungen und Proxmox-Cluster.

---

# nexus-courier (English)

`nexus-courier` is a robust bash script designed to automatically send status reports or log files from Linux servers via email. It is built to serve as a reliable courier within complex network infrastructures.

## Features
- **Flexible:** Recipient can be passed as a parameter during execution.
- **Robust:** Validates dependencies (`msmtp`, `cat`) and configuration file existence before sending.
- **Documented:** Built-in help function (`-h`).
- **Headless-Ready:** Ideal for Ubuntu Server environments and Proxmox clusters.

## Installation & Setup
1. Ensure `msmtp` is installed.
2. Configure your `~/.msmtprc` (see your provider's SMTP settings).
3. Set execution permission: `chmod +x nexus-courier.sh`

## Usage
`./nexus-courier.sh [RECIPIENT]`


###  Powerd by AI
