# Build an IPSec VPN Container

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
            autotools-dev   \
            autoconf    \
            automake \
            libtool \
            build-essential \
            git \
            net-tools \
            ca-certificates \
            curl \
            libcurl4-openssl-dev \
            openssl \
            libssl-dev \ 
            bzip2   \   
            libtalloc-dev   \
            libkqueue-dev   \
            libmariadbclient-dev    \
            libmariadb-dev  \
            devscripts   \
            quilt   \
            debhelper   \
            fakeroot   \
            equivs  

RUN apt-get -y install linux-headers-generic

RUN git clone https://github.com/FreeRADIUS/freeradius-server.git &&    \
    cd freeradius-server && git checkout v3.0.x

RUN cd ./freeradius-server && ./configure --enable-developer &&  \
            make &&  \
            make install

# clean up
RUN rm -rf ./freeradius-server

# remove compilers and development libraries
RUN apt-get -y remove base \
            build-essential \
            autotools-dev   \
            autoconf    \
            libcurl4-openssl-dev \
            libssl-dev  \
            libtalloc-dev   \
            libkqueue-dev

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

RUN addgroup radius
# RUN adduser radius radius

ADD --chown=root:radius ./etc/raddb/ /etc/raddb

RUN /etc/raddb/certs/bootstrap && \
    chown -R root:radius /etc/raddb/certs && \
    chmod 640 /etc/raddb/certs/*.pem

ADD ./scripts/start.sh /start.sh
ADD ./scripts/wait-for.sh /wait-for.sh

RUN chmod +x /start.sh wait-for.sh

# CMD ["/start.sh"]

# VOLUME \
#     /opt/db/ \
#     /etc/freeradius/certs

# EXPOSE \
#     1812/udp \
#     1813/udp \
#     18120

# CMD ["radiusd","-xx","-f"]