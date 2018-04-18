#!/bin/bash
#takes 1 argument as DNASRR,RNASRR,Individual,Timepoint
DNA=$(echo ${1} | cut -d, -f1)
RNA=$(echo ${1} | cut -d, -f2)
INDIV=$(echo ${1} | cut -d, -f3)
TIME=$(echo ${1} | cut -d, -f4)
mkdir ${INDIV}_${TIME}
mkdir ${INDIV}_${TIME}/rna
mkdir ${INDIV}_${TIME}/dna
fastq-dump --split-files $DNA
cat $DNA_1.fastq $DNA_2.fastq > $DNA.fastq
mv $DNA_1.fastq ${INDIV}_${TIME}/dna
mv $DNA_2.fastq ${INDIV}_${TIME}/dna
humann2 -i ${DNA}.fastq --metaphlan-options "--nproc 16" --output $DNA
mv ${DNA}/${DNA}_genefamilies.tsv ${INDIV}_${TIME}/dna
mv ${DNA}/${DNA}_pathabundance.tsv ${INDIV}_${TIME}/dna
mv ${DNA}/${DNA}_pathcoverage.tsv ${INDIV}_${TIME}/dna
mv ${DNA}/${DNA}_humann2_temp/${DNA}.log ${INDIV}_${TIME}/dna
mv ${DNA}/${DNA}_humann2_temp/${DNA}_metaphlan_bugs_list.tsv ${INDIV}_${TIME}/dna
humann2_renorm_table --input ${INDIV}_${TIME}/dna/${DNA}_pathabundance.tsv --units relab --output {INDIV}_${TIME}/dna/${DNA}_pathabundance_relab.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/dna/${DNA}_pathabundance.tsv --units cpm --output {INDIV}_${TIME}/dna/${DNA}_pathabundance_cpm.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/dna/${DNA}_genefamilies.tsv --units relab --output {INDIV}_${TIME}/dna/${DNA}_genefamilies_relab.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/dna/${DNA}_genefamilies.tsv --units cpm --output {INDIV}_${TIME}/dna/${DNA}_genefamilies_cpm.tsv
fastq-dump --split-files $RNA
cat $RNA_1.fastq $RNA_2.fastq > $RNA.fastq
mv $RNA_1.fastq ${INDIV}_${TIME}/rna
mv $RNA_2.fastq ${INDIV}_${TIME}/rna

humann2 -i ${RNA}.fastq --metaphlan-options "--nproc 16" --taxonomic-profile ${INDIV}_${TIME}/dna/${DNA}_metaphlan_bugs_list.tsv  --output $RNA
mv ${RNA}/${RNA}_genefamilies.tsv ${INDIV}_${TIME}/rna
mv ${RNA}/${RNA}_pathabundance.tsv ${INDIV}_${TIME}/rna
mv ${RNA}/${RNA}_pathcoverage.tsv ${INDIV}_${TIME}/rna
mv ${RNA}/${RNA}_humann2_temp/${RNA}.log ${INDIV}_${TIME}/rna
mv ${RNA}/${RNA}_humann2_temp/${RNA}_metaphlan_bugs_list.tsv ${INDIV}_${TIME}/rna
humann2_renorm_table --input ${INDIV}_${TIME}/rna/${RNA}_pathabundance.tsv --units relab --output {INDIV}_${TIME}/rna/${RNA}_pathabundance_relab.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/rna/${RNA}_pathabundance.tsv --units cpm --output {INDIV}_${TIME}/rna/${RNA}_pathabundance_cpm.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/rna/${RNA}_genefamilies.tsv --units relab --output {INDIV}_${TIME}/rna/${RNA}_pathabundance_relab.tsv
humann2_renorm_table --input ${INDIV}_${TIME}/rna/${RNA}_genefamilies.tsv --units cpm --output {INDIV}_${TIME}/rna/${RNA}_pathabundance_cpm.tsv
mkdir ${INDIV}_${TIME}/relative
humann2_rna_dna_norm --input_dna ${INDIV}_${TIME}/dna/${DNA}_genefamilies.tsv --input_rna ${INDIV}_${TIME}/rna/${RNA}_genefamilies.tsv --output_basename ${INDIV}_${TIME}/relative
rm -rf $DNA
rm -rf $RNA
rm $RNA.fastq
rm $DNA.fastq
aws s3 cp ${INDIV}_${TIME}/ s3://jacob-pqe/${INDIV}_${TIME}/ --recursive
rm -rf ${INDIV}_${TIME} 


