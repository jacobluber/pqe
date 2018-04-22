from __future__ import division
import os
import sys
from itertools import combinations


def set_to_key(input_set):
	input_list = list(input_set)
	input_list.sort()
	out = ",".join(map(lambda x: str(x),input_list))
	return out

ifh = open(sys.argv[1],'r')
d = {}
d[''] = 0

dna = ["d1","d2","d3","d4"]
rna = ["r1","r2","r3","r4"]

cross_lookup = {}
for elem in zip(dna,rna):
	cross_lookup[elem[0]] = elem[1]
	cross_lookup[elem[1]] = elem[0]

print cross_lookup

current = set()
for lines in ifh:
	sline = lines.rstrip()
	matching = False	
	if '>' in sline:
		for elem in current:
			if cross_lookup[elem] in current:
				matching = True
		if matching == True:	
			if set_to_key(current) in d.keys():
				existing = d[set_to_key(current)]
				existing += 1
				d[set_to_key(current)] = existing
			else:
				d[set_to_key(current)] = 1
		else:
			if "no_correspondence" in d.keys():
				existing1 = d["no_correspondence"]
				existing1 += 1
				d["no_correspondence"] = existing1
			else:
				d["no_correspondence"] = 1
		current = set()
	else:		
		current.add(sline)


total = sum(d.values())
print "total gene families: "+str(total)
for elem in d.keys():
	print elem+'\t'+str(d[elem])+'\t'+str(d[elem]/total)

