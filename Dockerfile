FROM ubuntu:14.04
MAINTAINER Frank Lemanschik <frank@github.dspeed.eu>
RUN sudo apt-get update -y
RUN sudo apt-get install -y apt-cacher apache2
#CMD apache2 -forgrround
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

#EXPOSE 80

#ENTRYPOINT ["/usr/sbin/apache2"]
#CMD ["-D", "FOREGROUND"]
