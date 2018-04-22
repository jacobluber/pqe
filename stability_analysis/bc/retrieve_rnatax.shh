#!/bin/bash
for x in $(cat indivs); do
	DNASRR1=$(aws s3 ls s3://jacob-pqe/${x}_1/rna/ | grep "genefamilies" | sed 's/.*SRR/SRR/g' | cut -d_ -f1) 
	DNASRR2=$(aws s3 ls s3://jacob-pqe/${x}_2/rna/ | grep "genefamilies" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR3=$(aws s3 ls s3://jacob-pqe/${x}_3/rna/ | grep "genefamilies" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR4=$(aws s3 ls s3://jacob-pqe/${x}_4/rna/ | grep "genefamilies" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	aws s3 cp s3://jacob-pqe/${x}_1/rna/${DNASRR1}_genefamilies.tsv /home/ubuntu/data/rna/${x}_rna_1.tsv
	sed -i "s/SRR.*RPKs/${x}_rna_1/g" /home/ubuntu/data/rna/${x}_rna_1.tsv
	aws s3 cp s3://jacob-pqe/${x}_2/rna/${DNASRR2}_genefamilies.tsv /home/ubuntu/data/rna/${x}_rna_2.tsv
        sed -i "s/SRR.*RPKs/${x}_rna_2/g" /home/ubuntu/data/rna/${x}_rna_2.tsv
	aws s3 cp s3://jacob-pqe/${x}_3/rna/${DNASRR3}_genefamilies.tsv /home/ubuntu/data/rna/${x}_rna_3.tsv
        sed -i "s/SRR.*RPKs/${x}_rna_3/g" /home/ubuntu/data/rna/${x}_rna_3.tsv
	aws s3 cp s3://jacob-pqe/${x}_4/rna/${DNASRR4}_genefamilies.tsv /home/ubuntu/data/rna/${x}_rna_4.tsv
        sed -i "s/SRR.*RPKs/${x}_rna_4/g" /home/ubuntu/data/rna/${x}_rna_4.tsv
done
humann2_join_tables --input /home/ubuntu/data/rna/ --output /home/ubuntu/data/rna.txt
humann2_renorm_table --input /home/ubuntu/data/rna.txt --units relab --output /home/ubuntu/data/rna.relab.txt
#norm
#https://s3.amazonaws.com/jacob-pqe/71936712_3/rna/SRR6038489_genefamilies.tsv
