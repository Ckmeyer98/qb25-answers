(qb25) cmdb@QuantBio-21 week1 % mv ~/Downloads/nhlf.bed .  

(qb25) cmdb@QuantBio-21 week1 % mv ~/Downloads/nhek.bed .   

(qb25) cmdb@QuantBio-21 week1 % grep 1_Active nhek.bed > nhek-active.bed  

(qb25) cmdb@QuantBio-21 week1 % grep 12_Repressed nhek.bed > nhek-repressed.bed

(qb25) cmdb@QuantBio-21 week1 % grep 1_Active nhlf.bed > nhlf-active.bed   

(qb25) cmdb@QuantBio-21 week1 % grep 12_Repressed nhlf.bed > nhlf-repressed.bed

(qb25) cmdb@QuantBio-21 week1 % wc -l nhek-active.bed

   #14013 nhek-active.bed

(qb25) cmdb@QuantBio-21 week1 % wc -l nhek-repressed.bed

   #32314 nhek-repressed.bed

(qb25) cmdb@QuantBio-21 week1 % wc -l nhlf-active.bed 

   #14888 nhlf-active.bed

(qb25) cmdb@QuantBio-21 week1 % wc -l nhlf-repressed.bed

   #34469 nhlf-repressed.bed

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -c -a nhek-active.bed -b nhlf-active.bed > nhek_and_nhlf

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -a nhek-active.bed -b nhlf-active.bed -v > nhek_not_nhlf

(qb25) cmdb@QuantBio-21 week1 % wc -l nhek_and_nhlf

   #14013 nhek_and_nhlf

(qb25) cmdb@QuantBio-21 week1 % wc -l nhek_not_nhlf

   #2405 nhek_not_nhlf

(qb25) cmdb@QuantBio-21 week1 % wc -l nhek-active.bed 

   #14013 nhek-active.bed

   #nhek_and_nhlf + nhek_not_nhlf > nhek-active.bed, so could account for overlap using -u argument to only count overlaps once

   (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed > nhek_nhlf_active_f1L

   (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_f1L

   #chr1    25558413        25559413

   #Shorter actively expressed sequence in NHEK centered on the longer actively expressed NHLF sequence

   (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed > nhek_nhlf_active_F1U

   (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_F1U

   #chr1    19923013        19924213

   #Shorter actively expressed sequence in NHLF centered on the longer actively expressed NHEK sequence

   (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed > nhek_nhlf_active_f1F1

   (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_f1F1

   #chr1    1051137 1051537

   #Both sequences have the same length of actively expressed chromatin at this locus

   # -f 1, -F 1, and -f 1 -F 1 all alter the "threshold" for overlap, -f based on A (NHEK), -F based on B (NHLF), and -f -F seems to make the two equal.
   
   (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -a nhek-active.bed -b nhlf-repressed.bed > nhek_nhlf_active_repressed_f1L

   (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_repressed_f1L  

    #chr1    1981140 1981540

    #Shorter actively expressed sequence at NHEK centered on a much longer repressed sequence in NHLF

    (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -F 1 -a nhek-active.bed -b nhlf-repressed.bed > nhek_nhlf_active_repressed_f1U

    (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_repressed_f1U

    #chr1    149575176       149575376

    #Regions of interest in NHEK and NHLF start at the same position; NHLF has a much shorter repressed sequence while NHEK has a larger actively expressed sequence

    (qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-repressed.bed > nhek_nhlf_active_repressed_f1F1

    (qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_active_repressed_f1F1

    #empty output; could indicate that there are no regions in the genome in which NHEK and NHLF have overlapping active/repressed sites of the same length

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -a nhek-repressed.bed -b nhlf-repressed.bed > nhek_nhlf_repressed_f1L

(qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_repressed_f1L

    #chr1    119531477       119542877

    #At this locus, both NHEK and NHLF are repressed. The repressed sequence is slightly longer in NHLF than in NHEK.

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -F 1 -a nhek-repressed.bed -b nhlf-repressed.bed > nhek_nhlf_repressed_F1U

(qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_repressed_F1U

    #chr1    11537413        11538213

    #At this locus, both NHLF and NHEK are both repressed, however the repressed sequence on NHEK extends much further both upstream and downstream

(qb25) cmdb@QuantBio-21 week1 % bedtools intersect -f 1 -F 1 -a nhek-repressed.bed -b nhlf-repressed.bed > nhek_nhlf_repressed_f1F1

(qb25) cmdb@QuantBio-21 week1 % less -s nhek_nhlf_repressed_f1F1

    #chr1    238137  242737

    #At this locus, NHEK and NHLF display the same length repressed sequence, and both are preceded by an upstream insulator.
