TBD

Installation
============

1.  Install and run MongoDB.  MongoDB is used to store metadata.
   
    ```
    $ echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list
    $ apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
    $ apt-get update
    $ apt-get install mongodb-10gen
    $ echo "bind_ip=127.0.0.1" >> /etc/mongodb.conf
    $ service mongodb restart
    ```
    
    **Nota bene** Everyone on the local machine has total access to the
    mongo server.
   
2.  Install various python packages.
   
    ```
    $ apt-get install python-pymongo \
                      python-gst0.10 \
                      python-gtk2 \
                      python-yaml
    $ easy_install poster
    ```

3.  Install GStreamer and its plugins. GStreamer is used to play media.
   
    ```
    $ apt-get install gstreamer0.10-ffmpeg \
                      gstreamer0.10-fluendo-mp3 \
                      gstreamer0.10-plugins-bad \
                      gstreamer0.10-plugins-bad-multiverse \
                      gstreamer0.10-plugins-base \
                      gstreamer0.10-plugins-good \
                      gstreamer0.10-plugins-ugly
    ```

4.  Compile and run `berthad`.  `berthad` will store the media files.
    
    ```
    $ cd berthad
    $ make
    $ mkdir data tmp
    $ ./berthad-vfs 127.0.0.1 10819 ./data ./tmp
    ```
    
    **Nota bene** Everyone on the local machine has total access to the
    bertha server.
    
5.  Configure and host `pijsmarietje`.
   
    ```
    $ cd /srv/default/htdocs # or *your* webdocs root
    $ ln -s /path/to/pijsmarietje pijsmarietje
    $ cp pijsmarietje/config.js{.example,}
    $ vi pijsmarietje/config.js
    ```
    
6.  Add a new admin user
    
    ```
    $ mongo
    > use marietje
    > db.users.insert({_id:'admin', n:"Admin", l:5, a:null, p:"md5ofpassword"})
    ```
    
7.  Set environment, create configuration and run maried. 
    
    ```
    $ source marietje-environment.sh # sets PATH and PYTHONPATH
    $ cp py/maried/examples/zuid.mirte mymariedconfig.mirte
    $ mymariedconfig.mirte
    $ mirte mymariedconfig
    ```
