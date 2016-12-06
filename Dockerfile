#latest debian:jessie
FROM armhf/debian
MAINTAINER Pere Canadell <calhemp@gmail.com>

ENV PREFIX=/usr/local/firebird
ENV DEBIAN_FRONTEND noninteractive

#timezone for my propose (commented)
#RUN echo "Europe/Madrid"  | tee /etc/timezone \
#    && dpkg-reconfigure --frontend noninteractive tzdata

#install build and dependencies for make this base debian arm need libicu-dev libicu52 libatomic-ops-dev 
RUN apt-get update \
    && apt-get install -qy libncurses5-dev bzip2 curl gcc g++ make libicu-dev libicu52 libatomic-ops-dev 

#build firebird
RUN mkdir -p /home/firebird && \
    cd /home/firebird && \
    #last release in 05/12/2016
    curl -o firebird-source.tar.bz2 -L \
        "http://downloads.sourceforge.net/project/firebird/firebird/2.5.6-Release/Firebird-2.5.6.27020-0.tar.bz2" && \
    tar --strip=1 -xf firebird-source.tar.bz2 && \
    ./configure \
        --prefix=${PREFIX} --with-fbbin=${PREFIX}/bin --with-fbsbin=${PREFIX}/bin --with-fblib=${PREFIX}/lib \
        --with-fbinclude=${PREFIX}/include --with-fbdoc=${PREFIX}/doc --with-fbudf=${PREFIX}/UDF \
        --with-fbsample=${PREFIX}/examples --with-fbsample-db=${PREFIX}/examples/empbuild --with-fbhelp=${PREFIX}/help \
        --with-fbintl=${PREFIX}/intl --with-fbmisc=${PREFIX}/misc --with-fbplugins=${PREFIX} \
        --with-fblog=/var/firebird/log --with-fbglock=/var/firebird/run \
        --with-fbconf=/var/firebird/etc --with-fbmsg=${PREFIX} \
        --with-fbsecure-db=/var/firebird/system --with-system-icu && \
    make && \
    make silent_install && \
    #remove for slim image
    cd / && \
    rm -rf /home/firebird && \
    rm -rf ${PREFIX}/*/.debug && \
    #no remove libicu-dev, libcu52 because needs for password change with gsec software in script
    apt-get purge -qy --auto-remove libncurses5-dev bzip2 curl gcc g++ make libatomic-ops-dev && \
    apt-get clean -q && \
    rm -rf /var/lib/apt/lists/* 

ADD ./setPass.sh /home/setPass.sh
RUN /home/setPass.sh && rm -f /home/setPass.sh


VOLUME ["/databases", "/var/firebird/run", "/var/firebird/etc", "/var/firebird/log", "/var/firebird/system", "/tmp/firebird"]

EXPOSE 3050/tcp

ENTRYPOINT ["/usr/local/firebird/bin/fbguard"]
