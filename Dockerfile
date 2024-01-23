FROM python:3.10-slim

WORKDIR /usr/src/app

COPY autodelete.py .

RUN apt update \
    && apt install -y cron \
    && apt clean
    
RUN pip install qbittorrent-api logging

ENV QBITTORRENT_URL="http://localhost:8080/"
ENV QBITTORRENT_USERNAME="your_default_username"
ENV QBITTORRENT_PASSWORD="your_default_password"

RUN echo "*/1 * * * * /usr/src/app/autodelete.py" > /etc/cron.d/autodelete

RUN chmod 0644 /etc/cron.d/autodelete
RUN touch /var/log/cron.log
RUN ln -sf /dev/stdout /var/log/cron.log

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
CMD cron && tail -f /var/log/cron.log