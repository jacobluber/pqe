#takes SRA runinfo file and generates the best guess for sample pairing given that metadata for this paper is not public. 
import sys
import os

#deal with file io
runinfo_fh = open(sys.argv[1],'r')
output_fh = open(sys.argv[2],'w')
output_fh.write("Individual\tDNA\tRNA\tDNA_order\tRNA_order\n")
runinfo = []

#make a metadata association dictionary 
for line in runinfo_fh:
	runinfo.append(line.rstrip().split(','))
metadata_assoc = {}
for elem in runinfo:
	library_name = elem[11]
	id_and_time = elem[11].split('.')[0]
	seq_type = elem[11].split('.')[1]
	indiv = id_and_time.split('_')[0]
	time = int(id_and_time.split('_')[1][2:])
	run = elem[0]
	if metadata_assoc.has_key(indiv):
		if seq_type == "rna":
			metadata_assoc[indiv]["rna"][time] = run 
		else:
			metadata_assoc[indiv]["dna"][time] = run
	else:
		metadata_assoc[indiv] = {}
		metadata_assoc[indiv]["rna"] = {}
		metadata_assoc[indiv]["dna"] = {}
		if seq_type == "rna":
                        metadata_assoc[indiv]["rna"][time] = run
                else:
                        metadata_assoc[indiv]["dna"][time] = run

#takes metadata_assoc dictionary, open output file handle, and an individual and writes out tab deliminted entry ordered by timepoints needed to download both rna and dna files with sra tools. 
def write_to_file(d,output_fh,individual):
	if d.has_key(individual):
		dna = []
		rna = []
		dna_order = []
		rna_order = []
		for d_key in sorted(d[individual]["dna"].keys()):
			dna.append(d[individual]["dna"][d_key])
			dna_order.append(d_key)
		for r_key in sorted(d[individual]["rna"].keys()):
                        rna.append(d[individual]["rna"][r_key])
                        rna_order.append(r_key) 
		if len(dna) > 2:
			if len (rna) > 2:
				output_fh.write(str(individual)+'\t'+",".join(dna)+'\t'+",".join(rna)+'\t'+",".join(map(lambda x: str(x),dna_order))+'\t'+",".join(map(lambda y: str(y),rna_order))+'\n')

for individual in metadata_assoc.keys():
	write_to_file(metadata_assoc,output_fh,individual)

runinfo_fh.close()
output_fh.close()

