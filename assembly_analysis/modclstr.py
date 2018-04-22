from __future__ import division
import os
import sys
from itertools import combinations


ifh = open(sys.argv[1],'r')
d = {}

dna = ["d1","d2","d3","d4"]
rna = ["r1","r2","r3","r4"]

cross_lookup = {}
for elem in zip(dna,rna):
        cross_lookup[elem[0]] = elem[1]
        cross_lookup[elem[1]] = elem[0]

current = set()
for lines in ifh:
	sline = lines.rstrip()
	if '>' in sline:
		matching = False
		dna_bool = False
		rna_bool = False
		concordant = False
		all_concordant = True
		all_dna_concordant = True
		all_rna_concordant = True	
		for elem in current:
			if elem in dna:
				dna_bool = True
			if elem in rna:
				rna_bool = True
			if cross_lookup[elem] in current:
				concordant = True
			if cross_lookup[elem] not in current:
				all_concordant = False
				if elem in dna:
					all_dna_concordant = False
				if elem in rna:
					all_rna_concordant = False
		if dna_bool and rna_bool:
			matching = True
		#print current
		#print "all_concordant: "+all_concordant
		if concordant and matching:
			if "at_least_one_concordant" in d.keys():
                                m1 = d["at_least_one_concordant"]
                                m1 += 1
                                d["at_least_one_concordant"] = m1
                        else:
                                d["at_least_one_concordant"] = 1
		if all_concordant and matching:
			#print current
			if "all_concordant" in d.keys():
                                m2 = d["all_concordant"]
                                m2 += 1
                                d["all_concordant"] = m2
                        else:
                                d["all_concordant"] = 1
		if all_dna_concordant and matching: 
			if "all_dna_concordant" in d.keys():
                                m3 = d["all_dna_concordant"]
                                m3 += 1
                                d["all_dna_concordant"] = m3
                        else:
                                d["all_dna_concordant"] = 1
		if all_rna_concordant and matching:
			if "all_rna_concordant" in d.keys():
                                m4 = d["all_rna_concordant"]
                                m4 += 1
                                d["all_rna_concordant"] = m4
                        else:
                                d["all_rna_concordant"] = 1
		if matching: 
			if "at_least_one_matching" in d.keys():
				m5 = d["at_least_one_matching"]
				m5 += 1
				d["at_least_one_matching"] = m5
			else:
				d["at_least_one_matching"] = 1
		if dna_bool:
			if "total_families_with_dna" in d.keys():
                                m6 = d["total_families_with_dna"]
                                m6 += 1
                                d["total_families_with_dna"] = m6
                        else:
                                d["total_families_with_dna"] = 1		
		if rna_bool:
			if "total_families_with_rna" in d.keys():
                                m7 = d["total_families_with_rna"]
                                m7 += 1
                                d["total_families_with_rna"] = m7
                        else:
                                d["total_families_with_rna"] = 1
		if dna_bool and not rna_bool:
			if "dna_only" in d.keys():
				existing1 = d["dna_only"]
				existing1 += 1
				d["dna_only"] = existing1
			else:
				d["dna_only"] = 1
		if rna_bool and not dna_bool:
			if "rna_only" in d.keys():
				existing2 = d["rna_only"]
                                existing2 += 1
                                d["rna_only"] = existing2
                        else:
                        	d["rna_only"] = 1
		current = set()
	else:		
		current.add(sline)


#total = sum(d.values())
#print "total gene families: "+str(total)
sortedKeys = sorted(d.keys())
for elem in sortedKeys:
	print elem+'\t'+str(d[elem])
	#print elem+'\t'+str(d[elem])+'\t'+str(d[elem]/total)
ifh.close()
sys.stdout.flush()
sys.stdout.close()
