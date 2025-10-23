#!/bin/bash

# Indexing each BAM file
for file in *.bam
do
    samtools index "$file"
done

# Counting aligned reads and saving to 
for file in *.bam
do
    echo -n "${file}: " >> read_counts.txt
    samtools view -c "$file" >> read_counts.txt
done

# Creating a list of BAM file names
ls *.bam > bamListFile.txt

# run FreeBayes to discover variants 
freebayes -f sacCer3.fa -L bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf

# filter the variants based on their quality score and remove sites where any sample had missing data
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf

# FreeBayes has a quirk where it sometimes records haplotypes rather than individual variants; we want to override this behavior
vcfallelicprimitives -kg filtered.vcf > decomposed.vcf

# in very rare cases, a single site may have more than two alleles detected in your sample, remove them
vcfbreakmulti decomposed.vcf > biallelic.vcf