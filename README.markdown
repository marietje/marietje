TBD

Installation
============
(See section below for Vagrant instructions)

1.  If not installed already, install `git` and `python`.

    ```
    $ apt-get install git python
    ```

2.  Clone marietje and all subpackages.
   
    ```
    $ git clone git://github.com/marietje/marietje.git
    $ cd marietje
    $ git submodule sync
    $ git submodule update --init
    ```
   
3.  Install and run MongoDB.  MongoDB is used to store metadata.
   
    ```
    $ apt-get install mongodb-server
    ```
    
    **Nota bene** Everyone on the local machine has total access to the
    mongo server.
   
4.  Install various python packages.
   
    ```
    $ apt-get install python-pymongo \
                      python-gst-1.0 \
                      python-gtk2 \
                      python-yaml \
                      python-setuptools \
                      python-dev \
                      msgpack-python \
                      python-unidecode \
                      python-poster
    ```

    **Nota bene** It is possible that the `python-pymongo` package does not
    contain the native extension for BSON-decoding.  This is the case, when:

    ```
    $ python -c 'import bson; print bson.has_c()'
    False
    ```

    In that case, install `pymongo`, using Python's setuptools:

    ```
    $ apt-get remove python-pymongo && pip install pymongo
    ```

5.  Install GStreamer and its plugins. GStreamer is used to play media.
   
    ```
    $ apt-get install gstreamer1.0-fluendo-mp3 \
                      gstreamer1.0-plugins-bad \
                      gstreamer1.0-plugins-bad-multiverse \
                      gstreamer1.0-plugins-base \
                      gstreamer1.0-plugins-good \
                      gstreamer1.0-plugins-ugly
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

Vagrant
=======

Alternatively, you can use [vagrant](https://www.vagrantup.com) to
automatically create a virtual machine with marietje installed, as follows

    $ git clone git://github.com/marietje/marietje.git
    $ cd marietje
    $ git submodule sync
    $ git submodule update --init
    $ vagrant up

If the DHCP server on your LAN is configured to set DNS hostnames for
clients, then you can access the client running on the virtual machine
by visiting

    https://vagrant-marietje/

To get a shell on the virtual machine, execute

    vagrant ssh

Note that `maried` is running as the `maried` user from `/home/maried`.

There are two caveats with the marietje setup on the vagrant virtual machine

 * audio does not work &
 * the graphical display is not configured
