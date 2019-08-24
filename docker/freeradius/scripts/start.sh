#!/bin/sh

# if [ "${RAD_DEBUG}" = "yes" ]
#   then
#     /wait-for.sh ${DB_HOST}:${DB_PORT} -t 15 -- /usr/local/sbin/radiusd -X -f -d /etc/raddb
#   else
#     /wait-for.sh ${DB_HOST}:${DB_PORT} -t 15 -- /usr/local/sbin/radiusd -f -d /etc/raddb
# fi

if [ "${RAD_DEBUG}" = "yes" ]
  then
    /usr/local/sbin/radiusd -X -f -d /usr/local/etc/raddb
  else
    /usr/local/sbin/radiusd -f -d /usr/local/etc/raddb
fi
