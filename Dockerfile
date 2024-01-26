FROM httpd:2.4

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
  && apt-get -qq install --yes --no-install-recommends locales

RUN localedef --inputfile ru_RU --force --charmap UTF-8 --alias-file /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

ADD *.deb /tmp/

RUN dpkg --install /tmp/1c-enterprise-8.3.22.2239-common_8.3.22-2239_amd64.deb 2> /dev/null \
  && dpkg --install /tmp/1c-enterprise-8.3.22.2239-ws_8.3.22-2239_amd64.deb 2> /dev/null \
  && rm /tmp/*.deb

COPY container/webinst /usr/local/sbin/webinst
COPY container/index.html /usr/local/apache2/htdocs/index.html
COPY container/GitHub-Mark-32px.png /usr/local/apache2/htdocs/GitHub-Mark-32px.png

RUN ln -s /usr/local/apache2/conf/httpd.conf /httpd.conf

RUN mkdir /data

VOLUME /data
VOLUME /usr/local/apache2/conf
