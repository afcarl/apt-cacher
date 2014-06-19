apt-cacher
==========

A APT Cache Server that gets used by dockerimages/ubuntu-baseimage if detected.


Simply start and use it as apt proxy or change deb urls to http://containerhost:port/archive.ubuntu.com/ubuntu utopic main

gets envolved with a onbuild instruction that dynamicaly enables and disables apt cacher for ubuntu-baseimage

I am so proud of it it speeded up our docker container creation a lot !!!
