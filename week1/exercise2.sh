(qb25) cmdb@QuantBio-21 week1 % wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes

(qb25) cmdb@QuantBio-21 week1 %  grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes

(qb25) cmdb@QuantBio-21 week1 % bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed

(qb25) cmdb@QuantBio-21 week1 % mv ~/Downloads/hg16-kc.tsv .

(qb25) cmdb@QuantBio-21 week1 %  cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed> hg16-kc-count.bed

(qb25) cmdb@QuantBio-21 week1 % wc -l hg19-kc.bed

   #80270 hg19-kc.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -a hg19-kc.bed -b hg16-kc.bed -v > hg19_not_hg16

(qb25) cmdb@QuantBio-21 week1 % wc -l hg19_not_hg16 

   #42717 hg19_not_hg16

   #Some genes are in hg19 but not hg16 because hg19 is a more recent human genome reference assembly with additional genes mapped.

(qb25) cmdb@QuantBio-21 week1 % wc -l hg16-kc.bed

   #21365 hg16-kc.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -a hg16-kc.bed -b hg19-kc.bed -v > hg16_not_hg19

(qb25) cmdb@QuantBio-21 week1 % wc -l hg16_not_hg19

    #3460 hg16_not_hg19

    #Some genes are in hg16 but not hg19 because some of the mapped genes in the older hg16 may have been due to mistakes in sequencing that had been corrected by hg19
