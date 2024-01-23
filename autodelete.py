from qbittorrentapi import Client
import os
import schedule
import time
import logging
import sys

logging.basicConfig(stream=sys.stdout, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logging.info('Started qB-autodelete')

qbittorrent_url = os.getenv("QBITTORRENT_URL", "http://localhost/")
qbittorrent_port = os.getenv("QBITTORRENT_PORT", "8081")
qbittorrent_username = os.getenv("QBITTORRENT_USERNAME", "admin")
qbittorrent_password = os.getenv("QBITTORRENT_PASSWORD", "password")

def check_and_remove_finished():
    try:
        qb = Client(qbittorrent_url, qbittorrent_port, qbittorrent_username, qbittorrent_password)

        torrents = qb.torrents.info()

        for torrent in torrents:
            if torrent['amount_left'] == 0:
                logging.info(f"Torrent '{torrent['name']}' has finished downloading. Removing torrent (keeping files)")
                qb.torrents_delete(False, [torrent['hash']])
                
        qb.auth_log_out()
    except Exception as e:
        logging.error(f"Error in check_and_remove_finished: {e}")
    
schedule.every(1).minutes.do(check_and_remove_finished)
    
if __name__ == "__main__":
    try:
        while True:
            schedule.run_pending()
            time.sleep(1)
    except Exception as e:
        logging.error(f"Error in main loop: {e}")
    except KeyboardInterrupt:
        logging.info("Script interrupted by user.")

