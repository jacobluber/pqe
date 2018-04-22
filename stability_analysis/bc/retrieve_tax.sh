#!/bin/bash
for x in $(cat indivs); do
	DNASRR1=$(aws s3 ls s3://jacob-pqe/${x}_1/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1) 
	DNASRR2=$(aws s3 ls s3://jacob-pqe/${x}_2/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR3=$(aws s3 ls s3://jacob-pqe/${x}_3/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	DNASRR4=$(aws s3 ls s3://jacob-pqe/${x}_4/dna/ | grep "bug" | sed 's/.*SRR/SRR/g' | cut -d_ -f1)
	aws s3 cp s3://jacob-pqe/${x}_1/dna/${DNASRR1}_metaphlan_bugs_list.tsv /home/ubuntu/data/tax/${x}_tax_1.tsv
	sed -i "s/Metaphlan2_Analysis/${x}_tax_1/g" /home/ubuntu/data/tax/${x}_tax_1.tsv
	aws s3 cp s3://jacob-pqe/${x}_2/dna/${DNASRR2}_metaphlan_bugs_list.tsv /home/ubuntu/data/tax/${x}_tax_2.tsv
        sed -i "s/Metaphlan2_Analysis/${x}_tax_2/g" /home/ubuntu/data/tax/${x}_tax_2.tsv
	aws s3 cp s3://jacob-pqe/${x}_3/dna/${DNASRR3}_metaphlan_bugs_list.tsv /home/ubuntu/data/tax/${x}_tax_3.tsv
        sed -i "s/Metaphlan2_Analysis/${x}_tax_3/g" /home/ubuntu/data/tax/${x}_tax_3.tsv
	aws s3 cp s3://jacob-pqe/${x}_4/dna/${DNASRR4}_metaphlan_bugs_list.tsv /home/ubuntu/data/tax/${x}_tax_4.tsv
        sed -i "s/Metaphlan2_Analysis/${x}_tax_4/g" /home/ubuntu/data/tax/${x}_tax_4.tsv
done
humann2_join_tables --input /home/ubuntu/data/tax/ --output /home/ubuntu/data/tax.txt
humann2_renorm_table --input /home/ubuntu/data/tax.txt --units relab --output /home/ubuntu/data/tax.relab.txt
#10042055_1/dna/SRR6028627_metaphlan_bugs_list.tsv
