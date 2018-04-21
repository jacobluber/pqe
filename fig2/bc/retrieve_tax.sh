#!/bin/bash
for x in $(cat indivs); do
	DNASRR1=$(aws s3 ls s3://jacob-pqe/${x}_1/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1) 
	DNASRR2=$(aws s3 ls s3://jacob-pqe/${x}_2/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR3=$(aws s3 ls s3://jacob-pqe/${x}_3/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR4=$(aws s3 ls s3://jacob-pqe/${x}_4/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	aws s3 cp s3://jacob-pqe/${x}_1/dna/${DNASRR1}_metaphlan_bugs_list.tsv /home/ubuntu/data/tax/${x}_tax_1.tsv
	sed -i "s/Metaphlan2_Analysis/${1}_tax_1/g" /home/ubuntu/data/tax/${x}_tax_1.tsv
	aws s3 cp s3://jacob-pqe/${x}_1/dna/${DNASRR1}_metaphlan_bugs_list.tsv /
home/ubuntu/data/tax/${x}_tax_1.tsv
        sed -i "s/Metaphlan2_Analysis/${1}_tax_1/g" /home/ubuntu/data/tax/${x}_tax_1.tsv
done

#10042055_1/dna/SRR6028627_metaphlan_bugs_list.tsv
