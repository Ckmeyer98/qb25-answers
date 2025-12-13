#!/usr/bin/env python3
import numpy as np

# Parameters
Genome_Length = 1000000
Read_Length = 100
Desired_Coverage = 30
Number_Reads = (Desired_Coverage * Genome_Length) // Read_Length

max_start = Genome_Length - Read_Length

rng = np.random.default_rng(seed=1)

starts = rng.integers(low=0, high=max_start + 1, size=Number_Reads, dtype=np.int64)

# Use array to keep track of coverage
diff = np.zeros(Genome_Length + 1, dtype=np.int32)

np.add.at(diff, starts, 1)
np.add.at(diff, starts + Read_Length, -1)

coverage = np.cumsum(diff[:-1], dtype=np.int32)

# Output
out_file = "coverage_1Mbp_100bp_30x.txt"
np.savetxt(out_file, coverage, fmt="%d")

# pseudocode:

# num_reads = calculate_number_of_reads(genomesize, readlength, coverage)
# ​
# ## use an array to keep track of the coverage at each position in the genome
# genome_coverage = initialize_array_with_zero(genomesize)
# ​
# for i in range(len(num_reads)):

#   startpos = uniform_random(0,genomelength-readlength+1)
#   endpos = startpos + readlength
#   genomecoverage[startpos:endpos] += 1

# ## get the range of coverages observed
# maxcoverage = max(genomecoverage)​
# xs = list(range(0, maxcoverage+1))

# ## Get the poisson pmf at each of these
# poisson_estimates = get_poisson_estimates(xs, lambda = coverage)

# ## Get normal pdf at each of these (i.e. the density between each adjacent pair of points)
# normal_estimates = get_normal_estimates(xs, mean = genome_coverage, stddev = sqrt(genome_coverage))
# ​
# ## now plot the histogram and probability distributions
# ...