#!/bin/bash
#aws s3 ls s3://jacob-pqe/assemblies/ | sed 's/.*PRE //g' | sed 's/\///g' | grep -v ":" > assemblies
mkdir trajectories
for x in $(cat assemblies); do
        aws s3 cp s3://jacob-pqe/assemblies/${x}/trajectories trajectories/${x}/ --recursive;
done
