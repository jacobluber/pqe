#!/bin/bash
#aws s3 ls s3://jacob-pqe/assemblies/ | sed 's/.*PRE //g' | sed 's/\///g' | grep -v ":" > assemblies
mkdir trajectories 
for x in $(cat assemblies); do
	aws s3 cp s3://jacob-pqe/assemblies/${x}/trajectories trajectories/${x}/ --recursive;
done
for y in $(ls trajectories); do
	mv trajectories/${y}/dna.txt ${y}_dna.trj;
	mv trajectories/${y}/rna.txt ${y}_rna.trj;
done
rm -rf trajectories
for z in $(ls *.trj); do
	cat ${z} | sed -n -e '/-------------/,$p' | tail -9 | grep -v "no genes" | sed 's/lar/lag/g' > ${z}.txt;
done 
rm *.trj
echo "gained,singleton,lost,gained-lost,lost-gained-lost,gained-lost-gained,maintained,lost-gained" > dna.trj
echo "gained,singleton,lost,gained-lost,lost-gained-lost,gained-lost-gained,maintained,lost-gained" > rna.trj
for i in $(ls *dna.trj.txt); do
	tr '\n' ' ' < <(cat ${i} | sed 's/\t/,/g' | cut -d, -f2) >> dna.trj;
	echo '' >> dna.trj;
done
for j in $(ls *rna.trj.txt); do
	tr '\n' ' ' < <(cat ${j} | sed 's/\t/,/g' | cut -d, -f2) >> rna.trj;
	echo '' >> rna.trj;
done
rm *.txt
mv dna.trj dna.trj.txt
mv rna.trj rna.trj.txt
sed -i 's/ /,/g' rna.trj.txt
sed -i 's/,$//g' rna.trj.txt
sed -i 's/ /,/g' dna.trj.txt
sed -i 's/,$//g' dna.trj.txt
	
