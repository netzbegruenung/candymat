FROM postgres:11.5

COPY ./sql/* /docker-entrypoint-initdb.d/

RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.utf8
