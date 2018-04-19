#!/bin/bash
mkdir ${1}
DNASRR1=$(aws s3 ls s3://jacob-pqe/${1}_1/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR2=$(aws s3 ls s3://jacob-pqe/${1}_2/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR3=$(aws s3 ls s3://jacob-pqe/${1}_3/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
DNASRR4=$(aws s3 ls s3://jacob-pqe/${1}_4/dna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR1=$(aws s3 ls s3://jacob-pqe/${1}_1/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR2=$(aws s3 ls s3://jacob-pqe/${1}_2/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR3=$(aws s3 ls s3://jacob-pqe/${1}_3/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
RNASRR4=$(aws s3 ls s3://jacob-pqe/${1}_4/rna/ | grep "log" | sed 's/.*SRR/SRR/g' | cut -d. -f1)
aws s3 cp s3://jacob-pqe/${1}_1/dna/${DNASRR1}_genefamilies.tsv ${1}/${1}_dna_1.tsv
aws s3 cp s3://jacob-pqe/${1}_1/dna/${DNASRR1}_metaphlan_bugs_list.tsv ${1}/${1}_bugs_1.tsv
aws s3 cp s3://jacob-pqe/${1}_2/dna/${DNASRR2}_metaphlan_bugs_list.tsv ${1}/${1}_bugs_2.tsv
aws s3 cp s3://jacob-pqe/${1}_3/dna/${DNASRR3}_metaphlan_bugs_list.tsv ${1}/${1}_bugs_3.tsv
aws s3 cp s3://jacob-pqe/${1}_4/dna/${DNASRR4}_metaphlan_bugs_list.tsv ${1}/${1}_bugs_4.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_dna_1/g" ${1}/${1}_dna_1.tsv
aws s3 cp s3://jacob-pqe/${1}_1/rna/${RNASRR1}_genefamilies.tsv ${1}/${1}_rna_1.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_rna_1/g" ${1}/${1}_rna_1.tsv 
aws s3 cp s3://jacob-pqe/${1}_2/dna/${DNASRR2}_genefamilies.tsv ${1}/${1}_dna_2.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_dna_2/g" ${1}/${1}_dna_2.tsv
aws s3 cp s3://jacob-pqe/${1}_2/rna/${RNASRR2}_genefamilies.tsv ${1}/${1}_rna_2.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_rna_2/g" ${1}/${1}_rna_2.tsv
aws s3 cp s3://jacob-pqe/${1}_3/dna/${DNASRR3}_genefamilies.tsv ${1}/${1}_dna_3.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_dna_3/g" ${1}/${1}_dna_3.tsv
aws s3 cp s3://jacob-pqe/${1}_3/rna/${RNASRR3}_genefamilies.tsv ${1}/${1}_rna_3.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_rna_3/g" ${1}/${1}_rna_3.tsv
aws s3 cp s3://jacob-pqe/${1}_4/dna/${DNASRR4}_genefamilies.tsv ${1}/${1}_dna_4.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_dna_4/g" ${1}/${1}_dna_4.tsv
aws s3 cp s3://jacob-pqe/${1}_4/rna/${RNASRR4}_genefamilies.tsv ${1}/${1}_rna_4.tsv
sed -i "s/SRR[0-9]*_Abundance/${1}_rna_4/g" ${1}/${1}_rna_4.tsv
humann2_join_tables --input ${1} --file_name dna --output ${1}/${1}_dna.tsv
humann2_join_tables --input ${1} --file_name rna --output ${1}/${1}_rna.tsv  
humann2_join_tables --input ${1} --file_name bugs --output ${1}/${1}_bugs.tsv
humann2_renorm_table --input ${1}/${1}_dna.tsv --output ${1}/${1}_dna_relab.tsv --units relab
humann2_renorm_table --input ${1}/${1}_rna.tsv --output ${1}/${1}_rna_relab.tsv --units relab
humann2_renorm_table --input ${1}/${1}_bugs.tsv --output ${1}/${1}_bugs_relab.tsv --units relab
