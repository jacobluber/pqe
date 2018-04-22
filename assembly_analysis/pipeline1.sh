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
#rm -rf trajectories
for z in $(ls *.trj); do
	cat ${z} | sed -n -e '/-------------/,$p' | tail -9 | grep -v "no genes" | sed 's/lar/lag/g' > ${z}.txt;
done 
rm *.trj
echo "gained,singleton,lost,gained-lost,lost-gained-lost,gained-lost-gained,maintained,lost-gained" > dna.f.trj
echo "gained,singleton,lost,gained-lost,lost-gained-lost,gained-lost-gained,maintained,lost-gained" > rna.f.trj
for i in $(ls *dna.trj.txt); do
	tr '\n' ' ' < <(cat ${i} | sed 's/\t/,/g' | cut -d, -f3) >> dna.f.trj;
	echo '' >> dna.f.trj;
done
for j in $(ls *rna.trj.txt); do
	tr '\n' ' ' < <(cat ${j} | sed 's/\t/,/g' | cut -d, -f3) >> rna.f.trj;
	echo '' >> rna.f.trj;
done
rm *.txt
mv dna.f.trj dna.f.trj.txt
mv rna.f.trj rna.f.trj.txt
sed -i 's/ /,/g' rna.f.trj.txt
sed -i 's/,$//g' rna.f.trj.txt
sed -i 's/ /,/g' dna.f.trj.txt
sed -i 's/,$//g' dna.f.trj.txt
	
