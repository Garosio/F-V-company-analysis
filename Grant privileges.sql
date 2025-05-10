-- CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON `F&V company`.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;