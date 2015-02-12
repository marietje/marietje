#!/bin/bash

set -e

MARIEDHOME=/home/maried
USER=maried
PIDFILE=$MARIEDHOME/maried.pid
DAEMON=$MARIEDHOME/repo/bin/mirte
DAEMON_OPTS=init
LOGFILE=$MARIEDHOME/maried.log
export PYTHONPATH=$MARIEDHOME/repo/py:$PYTHONPATH

function start_maried {
    start-stop-daemon --start --pidfile $PIDFILE --startas /bin/sh --oknodo \
                    --make-pidfile --background --chdir $MARIEDHOME \
                    --user $USER --no-close -- \
                    -c "exec $DAEMON $DAEMON_OPTS > $LOGFILE 2>&1"
}

function stop_maried {
    start-stop-daemon --stop --pidfile $PIDFILE --oknodo
}

function maried_running {
    start-stop-daemon --status --pidfile $PIDFILE
}

case "$1" in
    start)
        start_maried
        ;;
    stop)
        stop_maried
        ;;
    status)
        ret=0
        maried_running || ret=$?
        if [ $ret -eq 0 ] ; then
            echo "running"
        else
            echo "not running"
        fi
        exit $ret
        ;;
    restart)
        start_maried
        stop_maried
        ;;

    *)
        echo "Usage "$1" {start|stop|restart|status}"
        exit 1
esac

exit 0
