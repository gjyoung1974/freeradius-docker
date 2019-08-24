# Build an RADIUS service container

FROM ubuntu:cosmic

LABEL MAINTAINER="Gordon Young <gjyoung1974@gmail.com>"
LABEL ORG="com.goyoung.cloud.util.vpn.radius"
LABEL PROJECT="radius"

RUN mkdir -p /freeradius
WORKDIR /freeradius

# Get current:
RUN apt-get -y update
RUN apt-get -y install apt-utils

# Install build tools & libraries
RUN apt-get -y install base \
            net-tools \
            openssl \
            build-essential \
            autoconf    \
            automake \
            libtool \
            git \
            ca-certificates \
            libcurl4-openssl-dev \
            libssl-dev \ 
            libtalloc-dev   \
            libkqueue-dev   \
            libmariadbclient-dev    \
            libmariadb-dev \
            linux-headers-generic   \
            libtalloc2  \
            libpcap-dev \
            snmpd   \
            snmp    \ 
            libsnmp-dev \
            libjson-c-dev  \
            unixodbc-dev    \
            libmemcached-dev    \
            libstoken-dev   \
            ruby-dev    \
            libgdbm-dev \
            libidn2-dev \
            libkrb5-dev \
            libldap2-dev    \
            libwbclient-dev \
            libwbclient-sssd-dev    \
            libyubikey-dev


# clone FreeRadius and select the v3.0.x branch
RUN git clone https://github.com/FreeRADIUS/freeradius-server.git &&    \
    cd freeradius-server && git checkout v3.0.x

# Compile it
RUN cd ./freeradius-server && ./configure  &&  \
            # --enable-developer &&  \
            make &&  \
            make install

# clean up
RUN rm -rf ./freeradius-server

# remove compilers and development libraries
RUN apt-get -y remove base \
            build-essential \
            autotools-dev   \
            autoconf    \
            automake \
            libtool \
            git \
            linux-headers-generic

            # should we remove these?
            # libcurl4-openssl-dev \
            # libssl-dev \
            # libmariadbclient-dev    \
            # libmariadb-dev  \

RUN apt -y autoremove

EXPOSE 1812/udp 1813/udp

ENV DB_HOST=localhost
ENV DB_PORT=3306
ENV DB_USER=radius
ENV DB_PASS=radpass
ENV DB_NAME=radius
ENV RADIUS_KEY=testing123
ENV RAD_CLIENTS=10.0.0.0/24
ENV RAD_DEBUG=no

#TODO: review this:
# # addgroup radius && \
# RUN adduser --disabled-password --gecos "" radius && \
#     usermod -aG radius radius

# ADD --chown=root:radius ./etc/raddb/ /etc/raddb

# RUN /etc/raddb/certs/bootstrap && \
#     chown -R root:radius /etc/raddb/certs && \
#     chmod 640 /etc/raddb/certs/*.pem

ADD ./scripts/start.sh /start.sh
# ADD ./scripts/wait-for.sh /wait-for.sh

RUN chmod +x /start.sh 
# RUN chmod +x /wait-for.sh

VOLUME \
    /opt/db/ \
    /etc/freeradius/certs   \
    /etc/raddb

EXPOSE \
    1812/udp \
    1813/udp \
    18120

# Start it!
CMD ["/start.sh"]

# Failing to link these dependancies
# Moar dependancies
# configure: WARNING: FAILURE: rlm_perl requires:  libperl.so libperl.so.
# configure: WARNING: FAILURE: rlm_python requires: python-binary.
# configure: WARNING: FAILURE: rlm_redis requires: hiredis.h libhiredis.
# configure: WARNING: FAILURE: rlm_securid requires: acexport.h libaceclnt.
# ruby???
# configure: WARNING: FAILURE: rlm_unbound requires:  libunbound unbound.h.
# configure: WARNING: yubikey headers not found. Use --with-yubikey-include-dir=<path>.
# configure: WARNING: silently not building rlm_sql_firebird.
# configure: WARNING: FAILURE: rlm_sql_firebird requires: libfbclient ibase.h.
# configure: WARNING: FAILURE: rlm_sql_mongo requires:  bson/bson.h libbson mongoc.h libmongoc-1.0.
# configure: WARNING: FAILURE: rlm_sql_sqlite requires: libsqlite3 sqlite.h.
# configure: WARNING: FAILURE: rlm_sql_iodbc requires: libiodbc is
# configure: WARNING: silently not building rlm_sql_db2.
# configure: WARNING: FAILURE: rlm_sql_db2 requires: libdb2 sqlcli.h.
