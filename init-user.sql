use mysql;
CREATE USER 'app'@'localhost' IDENTIFIED BY '123456';
GRANT ALL ON *.* TO 'app'@'localhost';
flush privileges;