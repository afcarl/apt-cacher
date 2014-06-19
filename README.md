apt-cacher
==========

A APT Cache Server that gets used by dockerimages/ubuntu-baseimage if detected.


Simply start and use it as apt proxy or change deb urls to http://containerhost:port/archive.ubuntu.com/ubuntu utopic main

gets envolved with a onbuild instruction that dynamicaly enables and disables apt cacher for ubuntu-baseimage

I am so proud of it it speeded up our docker container creation a lot !!!

mport existing cached Packages

Import any existing packages into the cache by creating symlinks:

       sudo /usr/share/apt-cacher/apt-cacher-import.pl -l /var/cache/apt/archives

Note, older distributions may have different options. Some require the -d option for symlinks. Jaunty may require -s for symlinks.

Load Packages on Server from CD

Around upgrade time, you may find it useful to get the CD image instead of using the slow update servers, and populate your cache using that.

1. Download your CD image(s) of choice.

2. Mount the CD image on the server running apt-cacher :

sudo mount -o loop /home/username_or_other_path/ubuntu-<image-version>-<image-type>-<arch>.iso /media/cdrom0

3. Run the import on the CD image, you need the -R is needed to recurse into the CD directory structure, the -r just makes sure they are copied to the cache instead of trying to link:

sudo /usr/share/apt-cacher/apt-cacher-import.pl -R -r /media/cdrom0

You should see the script saying that it is importing a lot of packages.

Configure the server's Apt process to run through the cache

In a terminal, type:

sudo nano /etc/apt/apt.conf.d/01proxy

Inside your new file, add a line that says:

Acquire::http::Proxy "http://<IP address or hostname of the apt-cacher server>:3142";

Save the file and then on the server run  apt-get update 

If that succeeds without errors then update your server with  apt-get dist-upgrade 

Once complete you may reboot the server if necessary and configure your other servers the same way. Note that this will not work well if the client you are configuring will change networks and not be able to communication with this Apt-Cacher server. See below for alternative options. 
