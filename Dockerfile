FROM percona:5.6.24
LABEL creater="dazuimao1990"
ENV MYSQL_VERSION=5.6.24
ENV TZ=Asia/Shanghai
ADD docker-entrypoint.sh /run/docker-entrypoint.sh
ADD ./run/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ADD ./run/mysqld.cnf /etc/mysql/percona-server.conf.d/mysqld.cnf
RUN fetchDeps=' \
		ca-certificates \
		wget \
	'; \
    rm -rf /etc/apt/sources.list /etc/apt/sources.list.d/*
COPY sources-aliyun-0.list /etc/apt/sources.list

RUN	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
    wget -O /usr/local/bin/env2file -q https://github.com/barnettZQG/env2file/releases/download/v0.1/env2file-linux; \
    chmod +x /run/docker-entrypoint.sh && chmod +x /usr/local/bin/env2file; \
    apt-get purge -y --auto-remove $fetchDeps
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql"]
# init sql scripts
COPY sql/*.sql /docker-entrypoint-initdb.d/
# change ENTRYPOINT exec some custom command
ENTRYPOINT [ "/run/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
