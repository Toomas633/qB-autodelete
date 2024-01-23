<img align="right" src="https://sonarcloud.io/api/project_badges/quality_gate?project=Toomas633_qB-autodelete">
<img align="left" src="https://github.com/Toomas633/qB-autodelete/actions/workflows/docker.yml/badge.svg">
<br>

# qB-autodelete

- [Local](#local)
  - [Prerequisites](#prerequisites)
  - [Environment Variables](#environment-variables)
  - [Cron Job Setup](#cron-job-setup)
- [Docker](#docker)
  - [Docker Compose](#docker-compose)

This script is designed to automatically remove completed torrents from qBittorrent to keep your system organized.

## Local

- [Prerequisites](#prerequisites)
- [Environment Variables](#environment-variables)
- [Cron Job Setup](#cron-job-setup)

### Prerequisites

Before running the script, ensure you have the following:

- Python 3.10 or higher installed
- Docker installed (optional, for containerized deployment)
- qBittorrent installed and accessible
- Python qBittorrent api and schedule packages `pip install qbittorrent-api schedule`

### Environment Variables

The script uses the following environment variables:

- `QBITTORRENT_URL`: qBittorrent server URL (default: http://localhost/)
- `QBITTORRENT_PORT`: qBittorrent server port (default: 8081)
- `QBITTORRENT_USERNAME`: qBittorrent username (default: admin)
- `QBITTORRENT_PASSWORD`: qBittorrent password (default: password)

### Cron Job Setup

To run the script automatically create a CRON job to start the script after reboot:
`echo "@reboot /paht/to/autodelete.py >> /path/to/autodelete.log 2>&1" > /etc/cron.d/qb-autodelete`

## Docker

### Docker Compose

If you want to use Docker Compose, create a docker-compose.yml file with the following content:

```yml
version: '3'
services:
  qb-autodelete:
    image: toomas633/qb-autodelete:latest
    environment:
      - QBITTORRENT_URL=http://your-qbittorrent-server/
      - QBITTORRENT_PORT=your-port
      - QBITTORRENT_USERNAME=your-username
      - QBITTORRENT_PASSWORD=your-password
```

Start container `docker-compose up -d`
