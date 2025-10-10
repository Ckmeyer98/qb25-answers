#!/usr/bin/env python3

import sys

#Process line by line a .sam file specified as the first command line argument

my_file = open(sys.argv[1])

my_dict = {}

count_dict = {}

for line in my_file:

    line = line.strip("\n")
    line = line.split("\t")
    #Skip header lines that begin with @
    if not line[0].startswith("@"):
        #Use a dictionary and count how many alignments there are for each chromosome (and unmapped) as reported in the RNAME field
        my_dict[line[2]] = line[0]
    #Count how many times each NM:i:count SAM tag occurs
    for field in line[11:]:
        if field.startswith("NM:i:"):
            count = int(field.split(":")[2])
            if count in count_dict:
                count_dict[count] += 1
            else:
                count_dict[count] = 1


#Print each dictionary key, value pair in the default order returned by .keys()

for key in my_dict.keys():
    print(key, my_dict[key])

#Print the dictionary keys in numerical order
    
for key in sorted(count_dict):
    print(key, count_dict[key])