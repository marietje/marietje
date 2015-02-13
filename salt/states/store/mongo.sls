mongodb-server:
    pkg:
        - installed
mongodb:
    service:
        - running
/root/ensure-adminUser-exists.py:
    file.managed:
        - mode: 700
        - source: salt://store/ensure-adminUser-exists.py
    cmd:
        - run
        - requires:
            - file: /root/ensure-adminUser-exists.py
