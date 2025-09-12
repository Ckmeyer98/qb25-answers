(qb25) cmdb@QuantBio-21 week1 % wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.chrom.sizes

(qb25) cmdb@QuantBio-21 week1 %  grep -v _ hg19.chrom.sizes | sed 's/M/MT/' > hg19-main.chrom.sizes

(qb25) cmdb@QuantBio-21 week1 % bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed

(qb25) cmdb@QuantBio-21 week1 % mv ~/Downloads/hg19-kc.tsv .

(qb25) cmdb@QuantBio-21 week1 %  cut -f1-3,5 hg19-kc.tsv > hg19-kc.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed> hg19-kc-count.bed
