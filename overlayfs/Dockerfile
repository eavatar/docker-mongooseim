FROM eavatar/builder

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y libodbc1
RUN wget http://packages.erlang-solutions.com/site/esl/mongooseim/FLAVOUR_1_main/mongooseim_1.5.0-1~ubuntu~trusty_amd64.deb &&\
    dpkg -i mongooseim_1.5.0-1~ubuntu~trusty_amd64.deb

RUN mkdir -p /dist
WORKDIR /dist

RUN mkdir -p etc/pam.d etc/sudoers.d lib usr/lib/mongooseim usr/lib/sudo usr/bin usr/sbin var/lib/mongooseim var/lib/sudo
RUN cp -r /usr/lib/mongooseim/* usr/lib/mongooseim/
RUN cp -r /usr/lib/sudo/* usr/lib/sudo/
RUN cp /usr/sbin/mongooseimctl usr/sbin/
RUN cp /usr/bin/sudo usr/bin
RUN cp /etc/sudoers etc/
RUN cp /etc/pam.conf etc/
RUN cp -r /etc/pam.d/* etc/pam.d/

RUN cp /lib/x86_64-linux-gnu/libselinux.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/libutil.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/libpcre.so.3 lib/
RUN cp /lib/x86_64-linux-gnu/libpam.so.0 lib/
RUN cp /lib/x86_64-linux-gnu/libaudit.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/libz.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/libcrypt.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 lib/
RUN cp /lib/x86_64-linux-gnu/libssl.so.1.0.0 lib/
RUN cp /lib/x86_64-linux-gnu/libexpat.so.1 lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_env.so lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_deny.so lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_unix.so lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_permit.so lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_cap.so lib/
RUN cp /lib/x86_64-linux-gnu/security/pam_umask.so lib/

RUN tar cf /overlayfs.tar .