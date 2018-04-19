#!/bin/bash
mkdir ${1}
aws s3 cp s3://jacob-pqe/${1}_1/relative-smoothed_dna.tsv ${1}/relative-smoothed_dna_1.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_dna_1/g" ${1}/relative-smoothed_dna_1.tsv
aws s3 cp s3://jacob-pqe/${1}_1/relative-smoothed_rna.tsv ${1}/relative-smoothed_rna_1.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_rna_1/g" ${1}/relative-smoothed_rna_1.tsv 
aws s3 cp s3://jacob-pqe/${1}_2/relative-smoothed_dna.tsv ${1}/relative-smoothed_dna_2.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_dna_2/g" ${1}/relative-smoothed_dna_2.tsv
aws s3 cp s3://jacob-pqe/${1}_2/relative-smoothed_rna.tsv ${1}/relative-smoothed_rna_2.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_rna_2/g" ${1}/relative-smoothed_rna_2.tsv
aws s3 cp s3://jacob-pqe/${1}_3/relative-smoothed_dna.tsv ${1}/relative-smoothed_dna_3.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_dna_3/g" ${1}/relative-smoothed_dna_3.tsv
aws s3 cp s3://jacob-pqe/${1}_3/relative-smoothed_rna.tsv ${1}/relative-smoothed_rna_3.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_rna_3/g" ${1}/relative-smoothed_rna_3.tsv
aws s3 cp s3://jacob-pqe/${1}_4/relative-smoothed_dna.tsv ${1}/relative-smoothed_dna_4.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_dna_4/g" ${1}/relative-smoothed_dna_4.tsv
aws s3 cp s3://jacob-pqe/${1}_4/relative-smoothed_rna.tsv ${1}/relative-smoothed_rna_4.tsv
sed -i "s/SRR[0-9]*_Abundance-RPKs/${1}_rna_4/g" ${1}/relative-smoothed_rna_4.tsv
humann2_join_tables --input ${1} --file_name dna --output ${1}/${1}_dna.tsv
humann2_join_tables --input ${1} --file_name rna --output ${1}/${1}_rna.tsv  
