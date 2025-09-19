 
genomes % cp ~/Data/References/sacCer3/sacCer3.fa.gz .

genomes % gunzip sacCer3.fa.gz  

genomes % bowtie2-build sacCer3.fa sacCer3  

variants % bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam

variants % samtools sort -o A01_01.bam A01_01.sam

variants % samtools index A01_01.bam 

variants % samtools idxstats A01_01.bam > A01_01.idxstats