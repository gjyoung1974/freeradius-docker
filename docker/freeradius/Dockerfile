FROM ubuntu:cosmic

LABEL MAINTAINER="Gordon Young <gjyoung1974@gmail.com>"

# Image details
LABEL org.goyoung.name="goyoung" \
      org.goyoung.description="Dockerize FreeRadius" \
      org.goyoung.url="https://github.com/gjyoung1974" \
      org.goyoung.vcs-type="Git" \
      org.goyoung.version="1.4.3" \
      org.goyoung.radius.version="3.0.17-r5"

RUN apt-get -y update && apt-get upgrade 
RUN apt-get -y install freeradius freeradius-mysql openssl

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

CMD ["/start.sh"]
