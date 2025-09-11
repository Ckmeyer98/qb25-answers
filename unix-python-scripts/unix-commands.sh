
(qb25) cmdb@QuantBio-21 unix-python-scripts % wc -l ce11_genes.bed    

   #53935 ce11_genes.bed

(qb25) cmdb@QuantBio-21 unix-python-scripts % cut -f 1 ce11_genes.bed | sort | uniq -c 

#5460 chrI
#6299 chrII
#4849 chrIII
#21418 chrIV
#12 chrM
# 9057 chrV
# 6840 chrX

(qb25) cmdb@QuantBio-21 unix-python-scripts % cut -f 6 ce11_genes.bed | sort | uniq -c
# 26626 -
# 27309 +

(qb25) cmdb@QuantBio-21 GTEx % cut -f 6 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3
# 2014 Skin
# 3326 Brain
# 3480 Blood
