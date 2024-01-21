from qbittorrentapi import Client
import os

qbittorrent_url = os.getenv("QBITTORRENT_URL", "http://localhost/")
qbittorrent_port = os.getenv("QBITTORRENT_PORT", "8081")
qbittorrent_username = os.getenv("QBITTORRENT_USERNAME", "admin")
qbittorrent_password = os.getenv("QBITTORRENT_PASSWORD", "password")

def check_and_remove_finished():
    qb = Client(qbittorrent_url, qbittorrent_port, qbittorrent_username, qbittorrent_password)

    torrents = qb.torrents.info()

    for torrent in torrents:
        if torrent['amount_left'] == 0:
            print(f"Torrent '{torrent['name']}' has finished downloading. Removing torrent (keeping files)...")
            qb.torrents_delete(False, [torrent['hash']])
            print(f"Torrent '{torrent['name']}' removed.")
            print("\n")
            
    qb.auth_log_out()
    
if __name__ == "__main__":
    try:
        check_and_remove_finished()
    except Exception as e:
        print(f"ERROR: {e}")

