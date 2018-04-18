#!/bin/bash
git pull
for x in $(cat ${1});do ./pipeline.sh ${x};done
