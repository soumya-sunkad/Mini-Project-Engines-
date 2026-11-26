-- Run on the Engine 1 laptop ONLY if teammates must connect to YOUR MySQL.
-- Replace the password. Also set bind-address = 0.0.0.0 in my.cnf / my.ini and restart MySQL.
CREATE USER IF NOT EXISTS 'team05'@'%' IDENTIFIED BY 'root123';
GRANT SELECT, INSERT, UPDATE, DELETE ON attendance_db.* TO 'team05'@'%';
FLUSH PRIVILEGES;
