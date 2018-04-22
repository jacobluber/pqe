#!/bin/bash
grep "PAIRED" SraRunInfo.csv > SraRunInfo_paired.csv
humann2 -i SRR6038537.fastq --metaphlan-options "--nproc 16" --output SRR6038537_output
