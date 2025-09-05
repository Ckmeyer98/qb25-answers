#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader (my_file)

Number_contigs = 0
Length_sum = 0

Contig_list = []

for ident, sequence in contigs:
    Length_sum = Length_sum + len(sequence)
    Number_contigs = Number_contigs + 1
    Contig_list.append(len(sequence))
Length_avg = Length_sum / Number_contigs
print (Length_sum)
print (Length_avg)
Contig_list.sort ( reverse=True )
print (Number_contigs)

print(Contig_list)

Contig_sum = 0

for i in range(len(Contig_list)):
    Contig_sum = Contig_sum + int(Contig_list[i])
    if Contig_sum >= (0.5 * Length_sum):
        break
print(Contig_list[i])




