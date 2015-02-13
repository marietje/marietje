#!/usr/bin/env python

import pymongo

DATABASE="marietje"

def main():
    conn = pymongo.MongoClient()
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
