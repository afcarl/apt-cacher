FROM ubuntu:14.04
MAINTAINER Frank Lemanschik <frank@github.dspeed.eu>
RUN sudo apt-get update -y
RUN sudo apt-get install -y apt-cacher apache2
CMD apache2 -forgrround
