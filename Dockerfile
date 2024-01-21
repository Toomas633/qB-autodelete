# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the script into the container at /usr/src/app
COPY autodelete.py .

# Install any dependencies
RUN pip install qbittorrent-api

# Set environment variables
ENV QBITTORRENT_URL="http://localhost:8080/"
ENV QBITTORRENT_USERNAME="your_default_username"
ENV QBITTORRENT_PASSWORD="your_default_password"

# Add the cron job
RUN echo "*/30 * * * * /usr/src/app/your_script.py >> /var/log/cron.log 2>&1" > /etc/cron.d/your_cron_job

# Give execution rights to the cron job
RUN chmod 0644 /etc/cron.d/your_cron_job

# Run cron in the foreground
CMD ["cron", "-f"]