#!/bin/bash
for x in $(cat gnus/${1});do ./pipeline.sh ${x};done
