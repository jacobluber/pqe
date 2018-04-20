#!/bin/bash
INDIV=${1}
mkdir ${1}
mkdir ${1}/fastq
mkdir ${1}/assemblies
mkdir ${1}/prokka
mkdir ${1}/trajectories 
mkdir ${1}/rna_mphlan
mkdir ${1}/faas
mkdir ${1}/genecatalogs
DNASRR1=$(aws s3 ls s3://jacob-pqe/${1}_1/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR2=$(aws s3 ls s3://jacob-pqe/${1}_2/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR3=$(aws s3 ls s3://jacob-pqe/${1}_3/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR4=$(aws s3 ls s3://jacob-pqe/${1}_4/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR1=$(aws s3 ls s3://jacob-pqe/${1}_1/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR2=$(aws s3 ls s3://jacob-pqe/${1}_2/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR3=$(aws s3 ls s3://jacob-pqe/${1}_3/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR4=$(aws s3 ls s3://jacob-pqe/${1}_4/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
aws s3 cp s3://jacob-pqe/${1}_1/dna/${DNASRR1}_1.fastq ${1}/fastq/${1}_1_dna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_1/dna/${DNASRR1}_2.fastq ${1}/fastq/${1}_1_dna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_1/rna/${RNASRR1}_1.fastq ${1}/fastq/${1}_1_rna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_1/rna/${RNASRR1}_2.fastq ${1}/fastq/${1}_1_rna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_2/dna/${DNASRR2}_1.fastq ${1}/fastq/${1}_2_dna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_2/dna/${DNASRR2}_2.fastq ${1}/fastq/${1}_2_dna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_2/rna/${RNASRR2}_1.fastq ${1}/fastq/${1}_2_rna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_2/rna/${RNASRR2}_2.fastq ${1}/fastq/${1}_2_rna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_3/dna/${DNASRR3}_1.fastq ${1}/fastq/${1}_3_dna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_3/dna/${DNASRR3}_2.fastq ${1}/fastq/${1}_3_dna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_3/rna/${RNASRR3}_1.fastq ${1}/fastq/${1}_3_rna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_3/rna/${RNASRR3}_2.fastq ${1}/fastq/${1}_3_rna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_4/dna/${DNASRR4}_1.fastq ${1}/fastq/${1}_4_dna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_4/dna/${DNASRR4}_2.fastq ${1}/fastq/${1}_4_dna_2.fastq

aws s3 cp s3://jacob-pqe/${1}_4/rna/${RNASRR4}_1.fastq ${1}/fastq/${1}_4_rna_1.fastq
aws s3 cp s3://jacob-pqe/${1}_4/rna/${RNASRR4}_2.fastq ${1}/fastq/${1}_4_rna_2.fastq

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_1_dna_1.fastq -2 ${1}/fastq/${1}_1_dna_2.fastq -o ${1}/assemblies/1_dna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/1_dna --prefix 1_dna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/1_dna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_1_rna_1.fastq -2 ${1}/fastq/${1}_1_rna_2.fastq -o ${1}/assemblies/1_rna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/1_rna --prefix 1_rna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/1_rna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_2_dna_1.fastq -2 ${1}/fastq/${1}_2_dna_2.fastq -o ${1}/assemblies/2_dna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/2_dna --prefix 2_dna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/2_dna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_2_rna_1.fastq -2 ${1}/fastq/${1}_2_rna_2.fastq -o ${1}/assemblies/2_rna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/2_rna --prefix 2_rna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/2_rna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_3_dna_1.fastq -2 ${1}/fastq/${1}_3_dna_2.fastq -o ${1}/assemblies/3_dna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/3_dna --prefix 3_dna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/3_dna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_3_rna_1.fastq -2 ${1}/fastq/${1}_3_rna_2.fastq -o ${1}/assemblies/3_rna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/3_rna --prefix 3_rna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/3_rna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_4_dna_1.fastq -2 ${1}/fastq/${1}_4_dna_2.fastq -o ${1}/assemblies/4_dna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/4_dna --prefix 4_dna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/4_dna/final.contigs.fa

/home/ubuntu/megahit/megahit -m 0.95 --mem-flag 2 -t 36 -1 ${1}/fastq/${1}_4_rna_1.fastq -2 ${1}/fastq/${1}_4_rna_2.fastq -o ${1}/assemblies/4_rna
sudo /home/ubuntu/prokka/bin/prokka --outdir ${1}/prokka/4_rna --prefix 4_rna --addgenes --metagenome --mincontiglen 1 --cpus 36 ${1}/assemblies/4_rna/final.contigs.fa

cat ${1}/prokka/1_dna/1_dna.faa ${1}/prokka/2_dna/2_dna.faa ${1}/prokka/3_dna/3_dna.faa ${1}/prokka/4_dna/4_dna.faa > ${1}/faas/d.faa
cat ${1}/prokka/1_rna/1_rna.faa ${1}/prokka/2_rna/2_rna.faa ${1}/prokka/3_rna/3_rna.faa ${1}/prokka/4_rna/4_rna.faa > ${1}/faas/r.faa
cat ${1}/prokka/1_dna/1_dna.faa ${1}/prokka/2_dna/2_dna.faa ${1}/prokka/3_dna/3_dna.faa ${1}/prokka/4_dna/4_dna.faa ${1}/prokka/1_rna/1_rna.faa ${1}/prokka/2_rna/2_rna.faa ${1}/prokka/3_rna/3_rna.faa ${1}/prokka/4_rna/4_rna.faa > ${1}/faas/a.faa

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

metaphlan2.py ${1}/fastq/${1}_1_rna_1.fastq,${1}/fastq/${1}_1_rna_2.fastq --bowtie2out ${1}/rna_mphlan/1_rna.bowtie2.bz2 --nproc 36 --input_type fastq > ${1}/rna_mphlan/1_rna_tax.txt
metaphlan2.py ${1}/fastq/${1}_2_rna_1.fastq,${1}/fastq/${1}_2_rna_2.fastq --bowtie2out ${1}/rna_mphlan/2_rna.bowtie2.bz2 --nproc 36 --input_type fastq > ${1}/rna_mphlan/2_rna_tax.txt
metaphlan2.py ${1}/fastq/${1}_3_rna_1.fastq,${1}/fastq/${1}_3_rna_2.fastq --bowtie2out ${1}/rna_mphlan/3_rna.bowtie2.bz2 --nproc 36 --input_type fastq > ${1}/rna_mphlan/3_rna_tax.txt
metaphlan2.py ${1}/fastq/${1}_4_rna_1.fastq,${1}/fastq/${1}_4_rna_2.fastq --bowtie2out ${1}/rna_mphlan/4_rna.bowtie2.bz2 --nproc 36 --input_type fastq > ${1}/rna_mphlan/4_rna_tax.txt

sudo rm -rf ${1}/fastq
sudo rm -rf ${1}/assemblies
aws s3 cp ${1} s3://jacob-pqe/assemblies/${1} --recursive
sudo rm -rf ${1}
