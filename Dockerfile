FROM eavatar/python

ADD overlayfs.tar /

VOLUME /usr/lib/mongooseim/etc

RUN echo mongooseim:x:102:106::/usr/lib/mongooseim/:/bin/sh >> /etc/passwd &&\
    echo mongooseim:x:106: >> /etc/group

RUN chown -R mongooseim:mongooseim /usr/lib/mongooseim &&\
    mkdir -p /etc/service/mongooseim

ADD mongoose-run.sh /etc/service/mongooseim/run
RUN chmod a+x /etc/service/mongooseim/run

EXPOSE 5222 5280 5269

CMD ["/run.sh"]

