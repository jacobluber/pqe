#!/bin/bash
/home/ubuntu/cdhit/cd-hit -i ${1}/faas/a.faa -o ${1}/genecatalogs/all -M 0 -T 36 -sc 1
/home/ubuntu/cdhit/cd-hit -i ${1}/faas/r.faa -o ${1}/genecatalogs/rna -M 0 -T 36 -sc 1
/home/ubuntu/cdhit/cd-hit -i ${1}/faas/d.faa -o ${1}/genecatalogs/dna -M 0 -T 36 -sc 1

D1=$(head -1 ${1}/prokka/1_dna/1_dna.faa | cut -d_ -f 1 | sed 's/>//g')
D2=$(head -1 ${1}/prokka/2_dna/2_dna.faa | cut -d_ -f 1 | sed 's/>//g')
D3=$(head -1 ${1}/prokka/3_dna/3_dna.faa | cut -d_ -f 1 | sed 's/>//g')
D4=$(head -1 ${1}/prokka/4_dna/4_dna.faa | cut -d_ -f 1 | sed 's/>//g')
R1=$(head -1 ${1}/prokka/1_rna/1_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R2=$(head -1 ${1}/prokka/2_rna/2_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R3=$(head -1 ${1}/prokka/3_rna/3_rna.faa | cut -d_ -f 1 | sed 's/>//g')
R4=$(head -1 ${1}/prokka/4_rna/4_rna.faa | cut -d_ -f 1 | sed 's/>//g')

cat ${1}/genecatalogs/dna.clstr | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${D1}.*/1/g" | sed "s/${D2}.*/2/g" | sed "s/${D3}.*/3/g" | sed "s/${D4}.*/4/g" > ${1}/genecatalogs/dna.clstr.mod
cat ${1}/genecatalogs/rna.clstr | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${R1}.*/1/g" | sed "s/${R2}.*/2/g" | sed "s/${R3}.*/3/g" | sed "s/${R4}.*/4/g" > ${1}/genecatalogs/rna.clstr.mod
cat ${1}/genecatalogs/all.clstr | sed 's/>Cluster/yolo/g' | sed 's/.*>//g' | sed 's/\.\.\..*//g' | sed 's/yolo/>Cluster/g' | sed "s/${D1}.*/d1/g" | sed "s/${D2}.*/d2/g" | sed "s/${D3}.*/d3/g" | sed "s/${D4}.*/d4/g" | sed "s/${R1}.*/r1/g" | sed "s/${R2}.*/r2/g" | sed "s/${R3}.*/r3/g" | sed "s/${R4}.*/r4/g" > ${1}/genecatalogs/all.clstr.mod

python /home/ubuntu/pqe/modclstr_sub.py ${1}/genecatalogs/dna.clstr.mod /home/ubuntu/pqe/easy_trajectory.txt >> ${1}/trajectories/dna.txt
python /home/ubuntu/pqe/modclstr_sub.py ${1}/genecatalogs/rna.clstr.mod /home/ubuntu/pqe/easy_trajectory.txt >> ${1}/trajectories/rna.txt
python /home/ubuntu/pqe/modclstr_complex.py ${1}/genecatalogs/all.clstr.mod >> ${1}/trajectories/all.txt

rm -rf ${1}/fastq
rm -rf ${1}/assemblies
aws s3 cp ${1} s3://jacob-pqe/assemblies/{1} --recursive
rm -rf ${1}
