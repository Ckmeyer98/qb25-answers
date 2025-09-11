
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

(qb25) cmdb@QuantBio-21 unix-python-scripts % cut -f 7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3
# 867 Lung
# 1132 Muscle - Skeletal
# 3288 Whole Blood

(qb25) cmdb@QuantBio-21 unix-python-scripts % cut -f 12 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c
#  376 
#  117 DNA Extraction from Paxgene-derived Lysate Plate Based
#   87 DNA Isolation from Tissue via QIAgen Spin Column
#   30 DNA Isolation of Compromised Blood with Autopure
#   40 DNA isolation_Whole Blood_QIAGEN Puregene (Autopure)
# 2285 DNA isolation_Whole Blood_QIAGEN Puregene (Manual)
# 11760 RNA Extraction from Paxgene-derived Lysate Plate Based
#  933 RNA isolation_PAXgene Blood RNA (Manual)
# 6387 RNA isolation_PAXgene Tissue miRNA
#  936 RNA isolation_Trizol Manual (Cell Pellet)
#    1 SMNABTCHT

(qb25) cmdb@QuantBio-21 unix-python-scripts % echo $((11760 + 933 + 6387 + 936))
# 20016

(qb25) cmdb@QuantBio-21 unix-python-scripts % wc -l GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
# 22952 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

(qb25) cmdb@QuantBio-21 unix-python-scripts % echo $((22952 - 20016))
# 2936