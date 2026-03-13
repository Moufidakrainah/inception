FROM debian:bookworm
RUN apt-get update && apt-get install -y mariadb-server
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh
EXPOSE 3306
CMD ["/init_db.sh"]
