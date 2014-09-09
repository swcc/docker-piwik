#!/usr/bin/env sh

# ###############
# MySQL DB setup if doesn't exist
if [ ! -f /var/lib/mysql/ibdata1 ]; then
    /usr/bin/mysql_install_db
fi

# Reset root password to root
# Allow local access for root user
/usr/bin/mysqld_safe --skip-grant-tables > /dev/null 2>&1 &
/bin/sleep 2s
mysql -uroot mysql -e "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';FLUSH PRIVILEGES;"
/usr/bin/mysqladmin -uroot -proot shutdown
/usr/bin/mysqld_safe > /dev/null 2>&1 &
/bin/sleep 2s
mysql -uroot -proot mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root';"
# ###############

# ###############
# Create Database dev DB
mysql -uroot -proot -e "CREATE DATABASE piwik_db"
# Create (unsafe) HelpSpot user, who can connect remotely
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON piwik_db.* to 'piwik'@'%' IDENTIFIED BY 'piwik_password';"
# ###############

# Shutdown MySQL
/usr/bin/mysqladmin -uroot -proot shutdown

# Start normal phusion/baseimage init process
/sbin/my_init
