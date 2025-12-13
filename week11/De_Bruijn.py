#!/usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT',
         'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']

k = 3
out_file = "dbg_k3.dot"

edges = set()

for read in reads:
    for i in range(len(read) - k):
        left = read[i:i+k]
        right = read[i+1:i+1+k]
        edges.add((left, right))

with open(out_file, "w") as f:
    f.write("digraph DeBruijn {\n")
    f.write("  rankdir=LR;\n")
    f.write("  node [shape=box];\n")

    for left, right in sorted(edges):
        f.write(f'  "{left}" -> "{right}";\n')

    f.write("}\n")

print(f"Wrote {len(edges)} edges to {out_file}")