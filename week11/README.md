1.1: How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?

Answer: 

1 MBP = 1,000,000 bp

1,000,000 * 3 (coverage) = 3,000,000

3,000,000 / 100 = 30,000 reads
1.4: In your simulation, how much of the genome has not been sequenced (has 0x coverage)?

Answer: Based on the histogram, it looks like about 5% of the genome has not been sequenced.

How well does this match Poisson expectations? How well does the normal distribution fit the data?

Answer: Based on the overlay of the histogram, the data match Poisson expectations very closely. The
normal distribution is fairly close but not as much as Poisson. The normal distribution is shifted to
the right relative to the genome coverage histogram, indicating that it predicted that more of the genome
would have a higher number of reads than what I observed.

1.5: In your simulation, how much of the genome has not been sequenced (has 0x coverage)?

Answer: Based on the histogram, it looks like less than 1% of the genome has not been sequenced (close to 0)

How well does this match Poisson expectations? How well does the normal distribution fit the data?

Answer: The Poisson curve is an almost perfect fit to the histogram. The normal distribution is still right shifted
in relationship to the histogram but it seems closer than the 3X coverage.

1.6: In your simulation, how much of the genome has not been sequenced (has 0x coverage)?

Answer: Practically the entire genome has been sequenced with 30X coverage - only a few individual bases remain unsequenced.

How well does this match Poisson expectations? How well does the normal distribution fit the data?

Answer: Both the Poisson curve and the normal distribution align really closely to the histogram.

2.4: use dot to produce a directed graph. Record the command you used in your READMD.md

Answer:
dot -Tpng dbg_k3.dot -o ex2_digraph.png

2.5: Using your graph from Step 2.4, write one possible genome sequence that would produce these reads.

Answer: TATTTCTTATTCATTGATTG

2.6: In a few sentences, what would it take to accurately reconstruct the sequence of the genome? 

Answer: To remove ambiguity and accurately reconstruct the sequence of the genome, you would probably need paired-end information.
Longer reads could also be useful to make the reconstruction more accurate.
