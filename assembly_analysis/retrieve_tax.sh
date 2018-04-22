#!/bin/bash
mkdir rnatax
for x in $(cat assemblies); do
	aws s3 cp s3://jacob-pqe/assemblies/${x}/rna_mphlan/1_rna_tax.txt rnatax/${x}_1_rna_tax.txt;
	sed -i "s/Metaphlan2_Analysis/${x}_rnatax_1/g" rnatax/${x}_1_rna_tax.txt;
	aws s3 cp s3://jacob-pqe/assemblies/${x}/rna_mphlan/2_rna_tax.txt rnatax/${x}_2_rna_tax.txt;
        sed -i "s/Metaphlan2_Analysis/${x}_rnatax_2/g" rnatax/${x}_2_rna_tax.txt;
	aws s3 cp s3://jacob-pqe/assemblies/${x}/rna_mphlan/3_rna_tax.txt rnatax/${x}_3_rna_tax.txt;
        sed -i "s/Metaphlan2_Analysis/${x}_rnatax_3/g" rnatax/${x}_3_rna_tax.txt;
	aws s3 cp s3://jacob-pqe/assemblies/${x}/rna_mphlan/4_rna_tax.txt rnatax/${x}_4_rna_tax.txt;
        sed -i "s/Metaphlan2_Analysis/${x}_rnatax_4/g" rnatax/${x}_4_rna_tax.txt;
done
humann2_join_tables --input rnatax --output rnatax.txt
humann2_renorm_table --input rnatax.txt --units relab --output rnatax_relab.txt
