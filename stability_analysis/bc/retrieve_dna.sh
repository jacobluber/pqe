#!/bin/bash
for x in $(cat indivs); do
	DNASRR1=$(aws s3 ls s3://jacob-pqe/${x}_1/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1) 
	DNASRR2=$(aws s3 ls s3://jacob-pqe/${x}_2/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR3=$(aws s3 ls s3://jacob-pqe/${x}_3/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR4=$(aws s3 ls s3://jacob-pqe/${x}_4/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	aws s3 cp s3://jacob-pqe/${x}_1/dna/${DNASRR1}_genefamilies_relab.tsv /home/ubuntu/data/dna/${x}_dna_1.tsv
	sed -i "s/SRR.*RPKs/${x}_dna_1/g" /home/ubuntu/data/dna/${x}_dna_1.tsv
	aws s3 cp s3://jacob-pqe/${x}_2/dna/${DNASRR2}_genefamilies_relab.tsv /home/ubuntu/data/dna/${x}_dna_2.tsv
        sed -i "s/SRR.*RPKs/${x}_dna_2/g" /home/ubuntu/data/dna/${x}_dna_2.tsv
	aws s3 cp s3://jacob-pqe/${x}_3/dna/${DNASRR3}_genefamilies_relab.tsv /home/ubuntu/data/dna/${x}_dna_3.tsv
        sed -i "s/SRR.*RPKs/${x}_dna_3/g" /home/ubuntu/data/dna/${x}_dna_3.tsv
	aws s3 cp s3://jacob-pqe/${x}_4/dna/${DNASRR4}_genefamilies_relab.tsv /home/ubuntu/data/dna/${x}_dna_4.tsv
        sed -i "s/SRR.*RPKs/${x}_dna_4/g" /home/ubuntu/data/dna/${x}_dna_4.tsv
done
humann2_join_tables --input /home/ubuntu/data/dna/ --output /home/ubuntu/data/dna.relab.txt
#10042055_1/dna/SRR6028627_genefamilies_relab.tsv
