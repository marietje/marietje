#!/bin/sh

set -e

MARIEDHOME=/home/maried
USER=maried
PIDFILE=$MARIEDHOME/maried.pid
DAEMON=$MARIEDHOME/repo/bin/mirte
DAEMON_OPTS=init
export PYTHONPATH=$MARIEDHOME/repo/py:$PYTHONPATH

case "$1" in
    start)
        start-stop-daemon --start --pidfile $PIDFILE --exec $DAEMON --oknodo \
                        --chdir $MARIEDHOME --user $USER -- $DAEMON_OPTS
        ;;
    stop)
        start-stop-daemon --stop --pidfile $PIDFILE --oknodo
        ;;
    status)
        start-stop-daemon --status --pidfile $PIDFILE || ret=$?
        if [ $ret -eq 0 ]; then
            echo "running"
        else
            echo "not running"
        fi
        ;;
    restart)
        start-stop-daemon --stop --pidfile $PIDFILE --oknodo
        start-stop-daemon --start --pidfile $PIDFILE --exec $DAEMON --oknodo \
                        --chdir $MARIEDHOME --user $USER -- $DAEMON_OPTS
        ;;

    *)
        echo "Usage "$1" {start|stop|restart|status}"
        exit 1
esac

exit 0
