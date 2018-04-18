#takes SRA runinfo file and generates the best guess for sample pairing given that metadata for this paper is not public. 
import sys
import os

#deal with file io
runinfo_fh = open(sys.argv[1],'r')
output_fh = open(sys.argv[2],'w')
#output_fh.write("Individual\tDNA\tRNA\tDNA_order\tRNA_order\n")
runinfo = []

#make a metadata association dictionary 
for line in runinfo_fh:
	runinfo.append(line.rstrip().split(','))
metadata_assoc = {}
for elem in runinfo:
	library_name = elem[11]
	split_data = elem[11].split('_')
	seq_type = split_data[2]
	indiv = split_data[0]
	time = int(split_data[1][2:])
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
		if len(dna) > 3:
			if len(rna) > 3:
				if len(rna) == len(dna):
					timepoint_arr = []
					individual_arr = []
					count = 1
					for arb_unit in range(0,len(dna)):
						individual_arr.append(individual)
						timepoint_arr.append(count)
						count+=1
					for x in zip(dna,rna,individual_arr,timepoint_arr):
						t=map(lambda y: str(y),x)
						output_fh.write(",".join(t)+'\n')
					#output_fh.write("\t".join(map(lambda x: str(x[0])+','+str(x[1])+','+str(x[2])+','+str(x[3]),zip(dna,rna,individual_arr,timepoint_arr)))+'\n')

for individual in metadata_assoc.keys():
	write_to_file(metadata_assoc,output_fh,individual)

runinfo_fh.close()
output_fh.close()
