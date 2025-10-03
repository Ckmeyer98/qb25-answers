(qb25) cmdb@QuantBio-21 week1 % wc -l snps-chr1.bed

   #1091148 snps-chr1.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -C -a hg19-kc.bed -b snps-chr1.bed > Gene_SNPs

# chr1    245912648       246670581       ENST00000490107.6_7     5445

#Human Gene SMYD3 (ENST00000490107.6_7) chr1:245,912,649-246,670,581 Size: 757,933 Exon Count: 12

#SMYD3 encodes a histone methyltransferase. This is a critical epigenetic modulator, but perhaps there is overlap in function
#with other histone methyltransferases that permits tolerance of abundant SNPs. High SNP rate could also implicate SMYD3 as oncogene.

(qb25) cmdb@QuantBio-21 week1 % bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps_subset

(qb25) cmdb@QuantBio-21 week1 % bedtools sort -i snps_subset > snps_subset_sorted

(qb25) cmdb@QuantBio-21 week1 % bedtools sort -i hg19-kc.bed > hg19-kc_sorted 

(qb25) cmdb@QuantBio-21 week1 % bedtools closest -a snps_subset_sorted -b hg19-kc_sorted -d -t first > closest_snps_hg19kc 

#14 SNPs in gene (appear as 0s in closest_snps_hg19kc)

# SNPs outside the gene range from 1664 to 22944 bases away