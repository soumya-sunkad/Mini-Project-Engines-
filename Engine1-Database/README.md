# Engine 1 - Data & Integrity (MySQL)
Owner pushes daily: `schema.sql` changes + every query in `queries_log.sql`.

## Setup
    mysql -u root -p < schema.sql

## Let teammates connect (optional)
1. Find your laptop IP (`ipconfig` on Windows). All laptops must be on the same Wi-Fi/hotspot.
2. Run `remote_access.sql`, set `bind-address = 0.0.0.0`, restart MySQL, allow port 3306 in the firewall.
3. Give the Engine 3 owner: your IP, user `team05`, your password.

If this is too hard, each person can simply run `schema.sql` on their own laptop.
