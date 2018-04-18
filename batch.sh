#!/bin/bash
for x in $(cat ${1});do ./pipeline.sh ${x};done
