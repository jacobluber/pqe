#!/bin/bash
D1=$(head -1 ${4}_1_dna.faa | cut -d_ -f 1 | sed 's/>//g') 
D2=$(head -1 ${4}_2_dna.faa | cut -d_ -f 1 | sed 's/>//g')
D3=$(head -1 ${4}_3_dna.faa | cut -d_ -f 1 | sed 's/>//g')
D4=$(head -1 ${4}_4_dna.faa | cut -d_ -f 1 | sed 's/>//g')
R1=$(head -1 ${4}_1_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R2=$(head -1 ${4}_2_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R3=$(head -1 ${4}_3_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R4=$(head -1 ${4}_4_rna.faa | cut -d_ -f 1 | sed 's/>//g')

cat ${1} | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${D1}.*/1/g" | sed "s/${D2}.*/2/g" | sed "s/${D3}.*/3/g" | sed "s/${D4}.*/4/g" > ${1}.mod

cat ${2} | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${R1}.*/1/g" | sed "s/${R2}.*/2/g" | sed "s/${R3}.*/3/g" | sed "s/${R4}.*/4/g" > ${2}.mod

cat ${3} | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${D1}.*/d1/g" | sed "s/${D2}.*/d2/g" | sed "s/${D3}.*/d3/g" | sed "s/${D4}.*/d4/g" | sed "s/${R1}.*/r1/g" | sed "s/${R2}.*/r2/g" | sed "s/${R3}.*/r3/g" | sed "s/${R4}.*/r4/g" > ${3}.mod
