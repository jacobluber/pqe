#!/bin/bash
echo "dna_only,all_rna_concordant,at_least_one_matching,at_least_one_concordant,total_families_with_dna,all_concordant,all_dna_concordant,total_families_with_rna" > rna_dna_stability.txt
for indiv in $(cat assemblies); do
	rm -rf all.clstr.mod
	aws s3 cp s3://jacob-pqe/assemblies/${indiv}/genecatalogs/all.clstr.mod all.clstr.mod 
	python modclstr.py all.clstr.mod | tr '\n' ' ' < <(python modclstr.py all.clstr.mod | sed 's/\t/,/g' | cut -d, -f2 ) >> rna_dna_stability.txt;
	echo '' >> rna_dna_stability.txt;
done
rm -rf all.clstr.mod
sed -i 's/ /,/g' rna_dna_stability.txt
sed -i 's/,$//g' rna_dna_stability.txt
