FROM percona:5.6.24
LABEL creater="dazuimao1990"
ENV MYSQL_VERSION=5.6.24
ENV TZ=Asia/Shanghai
ADD docker-entrypoint.sh /run/docker-entrypoint.sh
ADD ./run/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ADD ./run/mysqld.cnf /etc/mysql/percona-server.conf.d/mysqld.cnf
RUN  rm -rf /etc/apt/sources.list /etc/apt/sources.list.d/*
COPY sources-aliyun-0.list /etc/apt/sources.list

RUN	fetchDeps=' \
		ca-certificates \
		wget \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
    wget -O /usr/local/bin/env2file -q https://github.com/barnettZQG/env2file/releases/download/v0.1/env2file-linux; \
    chmod +x /run/docker-entrypoint.sh && chmod +x /usr/local/bin/env2file

ENV GOSU_VERSION 1.11
RUN set -eux; \
# save list of currently installed packages for later so we can clean up
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget; \
	if ! command -v gpg; then \
		apt-get install -y --no-install-recommends gnupg2 dirmngr; \
	fi; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
# for flaky keyservers, consider https://github.com/tianon/pgp-happy-eyeballs, ala https://github.com/docker-library/php/pull/666
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
# clean up fetch dependencies
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version; \
	gosu nobody true
	
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql"]
# init sql scripts
COPY sql/*.sql /docker-entrypoint-initdb.d/
# change ENTRYPOINT exec some custom command
ENTRYPOINT [ "/run/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
