#!/bin/bash

set -e

BERTHADHOME=/home/berthad
USER=berthad
PIDFILE=$BERTHADHOME/berthad.pid
DAEMON=$BERTHADHOME/build/berthad-vfs
# TODO bind to 0.0.0.0 and set firewall rules
DAEMON_OPTS="127.0.0.1 10819 $BERTHADHOME/data $BERTHADHOME/tmp"
LOGFILE=$BERTHADHOME/berthad.log
export PYTHONPATH=$BERTHADHOME/repo/py:$PYTHONPATH

function start_berthad {
    start-stop-daemon --start --pidfile $PIDFILE --startas /bin/sh --oknodo \
                    --make-pidfile --background --chdir $BERTHADHOME \
                    --user $USER --no-close -- \
                    -c "exec $DAEMON $DAEMON_OPTS > $LOGFILE 2>&1"
}

function stop_berthad {
    start-stop-daemon --stop --pidfile $PIDFILE --oknodo
}

function berthad_running {
    start-stop-daemon --status --pidfile $PIDFILE
}

case "$1" in
    start)
        start_berthad
        ;;
    stop)
        stop_berthad
        ;;
    status)
        ret=0
        berthad_running || ret=$?
        if [ $ret -eq 0 ] ; then
            echo "running"
        else
            echo "not running"
        fi
        exit $ret
        ;;
    restart)
        start_berthad
        stop_berthad
        ;;

    *)
        echo "Usage "$1" {start|stop|restart|status}"
        exit 1
esac

exit 0
