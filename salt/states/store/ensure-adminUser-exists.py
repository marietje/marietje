#!/usr/bin/env python

import time
import pymongo

DATABASE="marietje"

def main():
    # pymongo might not be up yet, so we retry
    conn = None
    n_tries = 0
    while True:
        try:
            conn = pymongo.MongoClient()
        except pymongo.errors.ConnectionFailure:
            n_tries += 1
            time.sleep(1)
            if n_tries < 10:
                continue
            raise
        break
    conn[DATABASE].users.update(
            {'_id': 'admin'}, # key
            {'_id': 'admin',
             'n': 'Admin',
             'l': 5,
             'a': None,
             'p': 'd41d8cd98f00b204e9800998ecf8427e'}, # md5("")
                upsert=True)

if __name__ == '__main__':
    main()
