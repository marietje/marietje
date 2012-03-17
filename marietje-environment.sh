#!/bin/bash

base="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PYTHONPATH=$base/py:$PYTHONPATH
export PATH=$base/bin:$PATH
