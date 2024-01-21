FROM python:3.10-slim

WORKDIR /usr/src/app

COPY autodelete.py .

RUN apt update \
    && apt install -y cron \
    && apt clean
    
RUN pip install qbittorrent-api

ENV QBITTORRENT_URL="http://localhost:8080/"
ENV QBITTORRENT_USERNAME="your_default_username"
ENV QBITTORRENT_PASSWORD="your_default_password"

RUN echo "*/30 * * * * /usr/src/app/autodelete.py >> /var/log/cron.log 2>&1" > /etc/cron.d/autodelete

RUN chmod 0644 /etc/cron.d/autodelete

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
CMD ["cron", "-f"]