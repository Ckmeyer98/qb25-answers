#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA


#====================#
# Read in parameters #
#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code

fasta_file = sys.argv[1]

sigma_file = sys.argv[2]

out_file = sys.argv[3]

gap_penalty = int(sys.argv[4])

#Preparing scoring matrix so it can be used lated

def read_scoring_matrix(sigma_file):
    sigma = {}

    with open(sigma_file, "r") as f:
        lines = [line.strip() for line in f if line.strip()]

    headers = lines[0].split()

    for line in lines[1:]:
        parts = line.split()
        row_char = parts[0]
        scores = parts[1:]

        for col_char, score in zip(headers, scores):
            sigma[(row_char, col_char)] = int(score)

    return sigma

# Reading the scoring matrix into a dictionary

fs = open(sigma_file)
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
    line = line.rstrip().split()
    for i in range(1, len(line)):
        sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

sigma = read_scoring_matrix(sigma_file)

# Read in the sequences using readFASTA

input_sequences = readFASTA(open(fasta_file))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]


#=====================#
# Initialize F matrix #
#=====================#

F_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=int)

#=============================#
# Initialize Traceback Matrix #
#=============================#

T_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=str)

#===================#
# Populate Matrices #
#===================#

for i in range(1, len(sequence1)+1):
    for j in range(1, len(sequence2)+1):
        a = sequence1[i-1]
        b = sequence2[j-1]

        d = F_matrix[i-1, j-1] + sigma[(a, b)]
        h = F_matrix[i,   j-1] + gap_penalty
        v = F_matrix[i-1, j  ] + gap_penalty

        # tie-breakers
        
        best = d
        direction = "D"

        if h > best:
            best = h
            direction = "H"

        if v > best:
            best = v
            direction = "V"

        F_matrix[i, j] = best
        T_matrix[i, j] = direction

#========================================#
# Follow traceback to generate alignment #
#========================================#

# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code

def traceback_alignment(sequence1, sequence2, T_matrix):
    i = len(sequence1)
    j = len(sequence2)

    aligned1 = []
    aligned2 = []

    while i > 0 or j > 0:
        if i == 0:
            aligned1.append("-")
            aligned2.append(sequence2[j-1])
            j -= 1
            continue

        if j == 0:
            aligned1.append(sequence1[i-1])
            aligned2.append("-")
            i -= 1
            continue

        move = T_matrix[i, j]

        if move == "D":
            aligned1.append(sequence1[i-1])
            aligned2.append(sequence2[j-1])
            i -= 1
            j -= 1
        elif move == "H":
            aligned1.append("-")
            aligned2.append(sequence2[j-1])
            j -= 1
        elif move == "V":
            aligned1.append(sequence1[i-1])
            aligned2.append("-")
            i -= 1

    # Turn lists into strings reverse to build backwards)
    sequence1_alignment = "".join(reversed(aligned1))
    sequence2_alignment = "".join(reversed(aligned2))

    return sequence1_alignment, sequence2_alignment

#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

#Convert from traceback function so I can use it in main code

sequence1_alignment, sequence2_alignment = traceback_alignment(sequence1, sequence2, T_matrix)

identity_alignment = []
for a, b in zip(sequence1_alignment, sequence2_alignment):
    if a == b and a != '-' and b != '-':
        identity_alignment.append('|')
    else:
        identity_alignment.append(' ')
identity_alignment = ''.join(identity_alignment)

#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

with open(out_file, "w") as output:
    for i in range(0, len(sequence1_alignment), 100):
        output.write(sequence1_alignment[i:i+100] + "\n")
        output.write(identity_alignment[i:i+100]  + "\n")
        output.write(sequence2_alignment[i:i+100] + "\n\n")


#=============================#
# Calculate sequence identity #
#=============================#

# Number of gaps

gaps_seq1 = sequence1_alignment.count('-')
gaps_seq2 = sequence2_alignment.count('-')

# Percent sequence identity

matches = 0
non_gap_seq1 = 0
non_gap_seq2 = 0

for a, b in zip(sequence1_alignment, sequence2_alignment):
    if a != '-':
        non_gap_seq1 += 1
    if b != '-':
        non_gap_seq2 += 1
    if a == b and a != '-' and b != '-':
        matches += 1

percent_id_seq1 = 100.0 * matches / non_gap_seq1 if non_gap_seq1 > 0 else 0.0
percent_id_seq2 = 100.0 * matches / non_gap_seq2 if non_gap_seq2 > 0 else 0.0

# Alignment score

alignment_score = F_matrix[len(sequence1), len(sequence2)]

#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score

print(f"Gaps in sequence 1: {gaps_seq1}")
print(f"Gaps in sequence 2: {gaps_seq2}")

print(f"Percent identity (sequence 1): {percent_id_seq1:.2f}%")
print(f"Percent identity (sequence 2): {percent_id_seq2:.2f}%")

print(f"Alignment score: {alignment_score}")