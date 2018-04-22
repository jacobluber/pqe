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
mappingfh = open(sys.argv[2],'r')
mapping_d = {}
d = {}
d[''] = 0
mapping_d[''] = "no genes"
for lines in mappingfh:
	line = lines.rstrip().split('\t')
	print line
	mapping_d[line[0]]=line[1]
	d[line[0]] = 0
categories = {}
for elem in mapping_d.values():
	categories[elem] = 0

current = set()
for lines in ifh:
	sline = lines.rstrip()
	if '>' in sline:
		existing = d[set_to_key(current)]
		existing += 1
		d[set_to_key(current)] = existing
		current = set()
	else:
		current.add(int(sline))

for x in mapping_d.keys():
	ex = categories[mapping_d[x]]
	ex += d[x]
	categories[mapping_d[x]] = ex

total = sum(d.values())
total2 = sum(categories.values())
print "total gene families: "+str(total)
sortedKeys = sorted(d.keys())
cKeys = sorted(categories.keys())
for elem in sortedKeys:
	print elem+'\t'+str(d[elem])+'\t'+str(d[elem]/total)
print "-------------"
for elem in cKeys:
	print elem+'\t'+str(categories[elem])+'\t'+str(categories[elem]/total)

