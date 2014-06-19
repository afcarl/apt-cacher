FROM ubuntu:14.04
MAINTAINER Frank Lemanschik <frank@github.dspeed.eu>
RUN apt-get update -y
RUN apt-get install -y apt-cacher apache2
#CMD apache2 -forgrround
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN cat <<EOF >  /etc/default/apt-cacher 
RUN echo "AUTOSTART=1" > /etc/default/apt-cacher 
RUN echo 'EXTRAOPT=" daemon_port=80 limit=30 "' >> /etc/default/apt-cacher 

RUN echo "allowed_hosts = *" >> /etc/apt-cacher/apt-cacher.conf
RUN echo "installer_files_regexp = ^(?:vmlinuz|linux|initrd\.gz|changelog|NEWS.Debian|[a-z]+\.tar\.gz(?:\.gpg)?|UBUNTU_RELEASE_NAMES\.tar\.gz(?:\.gpg)?|(?:Devel|EOL)?ReleaseAnnouncement(?:\.html)?|meta-release(?:-lts)?(?:-(?:development|proposed))?)$ " >> /etc/apt-cacher/apt-cacher.conf
RUN echo "installer_files_regexp = ^(?:vmlinuz|linux|initrd\.gz|changelog|NEWS.Debian|[a-z]+\.tar\.gz(?:\.gpg)?|UBUNTU_RELEASE_NAMES\.tar\.gz(?:\.gpg)?|(?:Devel|EOL)?ReleaseAnnouncement(?:\.html)?|meta-release(?:-lts)?(?:-(?:development|proposed))?)$ " >> /etc/apt-cacher/apt-cacher.conf
RUN echo "ubuntu_release_names = trusty, utopic"  >> /etc/apt-cacher/apt-cacher.conf
RUN echo "clean_cache = 1"  >> /etc/apt-cacher/apt-cacher.conf
RUN echo "daemon_port = 80" >> /etc/apt-cacher/apt-cacher.conf


RUN echo 'Acquire::http::Proxy "http://localhost";' > /etc/apt/apt.conf.d/01proxy
RUN echo ServerName localhost >> /etc/apache2/apache2.conf
RUN mkdir /var/lock/apache2
RUN mkdir /var/run/apache2
EXPOSE 80

CMD source /etc/apache2/envvars && \
    /bin/bash -c "/usr/sbin/apt-cacher &" && \
    /usr/sbin/apache2 -D FOREGROUND
