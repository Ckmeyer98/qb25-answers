#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader (my_file)

Number_configs = 0
Length_sum = 0

for ident, sequence in contigs:
    Length_sum = Length_sum + len(sequence)
    Number_configs = Number_configs + 1
Length_avg = Length_sum / Number_configs
print (Length_sum)
print (Length_avg)
print (Number_configs)

