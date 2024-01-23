FROM python:3.10-slim

WORKDIR /usr/src/app

COPY autodelete.py .
    
RUN pip install qbittorrent-api schedule

ENV QBITTORRENT_URL="http://localhost:8080/"
ENV QBITTORRENT_USERNAME="your_default_username"
ENV QBITTORRENT_PASSWORD="your_default_password"

CMD ["python", "autodelete.py"]