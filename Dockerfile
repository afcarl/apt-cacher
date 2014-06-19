FROM ubuntu:14.04
MAINTAINER Frank Lemanschik <frank@github.dspeed.eu>
RUN apt-get update -y
RUN apt-get install -y apt-cacher apache2
#CMD apache2 -forgrround
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN cat <<EOF >  /etc/default/apt-cacher 
    AUTOSTART=1
    EXTRAOPT=" daemon_port=80 limit=30 "
EOF

RUN cat <<EOF >> /etc/apt-cacher/apt-cacher.conf
allowed_hosts = *
installer_files_regexp = ^(?:vmlinuz|linux|initrd\.gz|changelog|NEWS.Debian|[a-z]+\.tar\.gz(?:\.gpg)?|UBUNTU_RELEASE_NAMES\.tar\.gz(?:\.gpg)?|(?:Devel|EOL)?ReleaseAnnouncement(?:\.html)?|meta-release(?:-lts)?(?:-(?:development|proposed))?)$
ubuntu_release_names = trusty, utopic
clean_cache = 1
daemon_port = 80
EOF
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
