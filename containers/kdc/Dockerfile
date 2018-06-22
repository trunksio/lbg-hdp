FROM alpine

ARG HTTP_PROXY=''
ENV HTTP_PROXY $HTTP_PROXY

ARG HTTPS_PROXY=''
ENV HTTPS_PROXY $HTTPS_PROXY

ARG NO_PROXY=''
ENV NO_PROXY $NO_PROXY

RUN apk add --no-cache krb5-server krb5 supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD docker-entrypoint.sh /
VOLUME /var/lib/krb5kdc
EXPOSE 749 464 88
ENTRYPOINT ["/docker-entrypoint.sh"]
