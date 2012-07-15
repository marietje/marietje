TBD

Installation
============

1.  If not installed already, install `git` and `python`.

    ```
    $ apt-get install git python
    ```

2.  Clone marietje and all subpackages.
   
    ```
    $ git clone git://github.com/marietje/marietje.git
    $ git submodule sync
    $ git submodule update --init
    ```
   
3.  Install and run MongoDB.  MongoDB is used to store metadata.
   
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
   
4.  Install various python packages.
   
    ```
    $ apt-get install python-pymongo \
                      python-gst0.10 \
                      python-gtk2 \
                      python-yaml \
                      python-setuptools \
                      python-dev
    $ easy_install poster msgpack-python
    ```

5.  Install GStreamer and its plugins. GStreamer is used to play media.
   
    ```
    $ apt-get install gstreamer0.10-ffmpeg \
                      gstreamer0.10-fluendo-mp3 \
                      gstreamer0.10-plugins-bad \
                      gstreamer0.10-plugins-bad-multiverse \
                      gstreamer0.10-plugins-base \
                      gstreamer0.10-plugins-good \
                      gstreamer0.10-plugins-ugly
    ```

6.  Compile and run `berthad`.  `berthad` will store the media files.
    
    ```
    $ apt-get install libglib2.0-dev cmake
    $ cd berthad/release
    $ ./build
    $ mkdir data tmp
    $ ./berthad-vfs 127.0.0.1 10819 ./data ./tmp
    ```
    
    **Nota bene** Everyone on the local machine has total access to the
    bertha server.
    
7.  Configure and host `pijsmarietje`.
   
    ```
    $ cd /srv/default/htdocs # or *your* webdocs root
    $ ln -s /path/to/pijsmarietje pijsmarietje
    $ cp pijsmarietje/config.js{.example,}
    $ vi pijsmarietje/config.js
    ```
    
8.  Add a new admin user
    
    ```
    $ mongo
    > use marietje
    > db.users.insert({_id:'admin', n:"Admin", l:5, a:null, p:"md5ofpassword"})
    ```

9.  Optionally, compile the `carah` module

    ```
    $ pushd carah && python setup.py build --inplace && mv *.so src && popd
    ```
    
10. Set environment, create configuration and run maried. 
    
    ```
    $ source marietje-environment.sh # sets PATH and PYTHONPATH
    $ cp py/maried/examples/zuid.mirte mymariedconfig.mirte
    $ vi mymariedconfig.mirte
    $ mirte mymariedconfig
    ```
