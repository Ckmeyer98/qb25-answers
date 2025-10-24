#!/usr/bin/env python3

vcf_file = "biallelic.vcf"
out_file = "gt_long.txt"

sample_ids = [
    "A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
    "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"
]

def to_binary_genotype(gt_token: str):
    gt = gt_token.strip()
    if gt == "0":
        return "0"
    if gt == "1":
        return "1"
    if gt in ("0/0", "0|0"):
        return "0"
    if gt in ("1/1", "1|1"):
        return "1"
    return None

with open(out_file, "w", encoding="utf-8") as out:
    out.write("sample_id\tchrom\tpos\tgenotype\n")

    for line in open(vcf_file, "r", encoding="utf-8"):
        if line.startswith("#"):
            continue 

        fields = line.rstrip("\n").split("\t")
        if len(fields) < 9:
            continue

        chrom = fields[0]
        pos   = fields[1]
        format_col = fields[8]
        for i, sample_id in enumerate(sample_ids):
            col_idx = 9 + i
            if col_idx >= len(fields):
                continue

            sample_entry = fields[col_idx]
            gt_token = sample_entry.split(":", 1)[0]
            bin_gt = to_binary_genotype(gt_token)

            if bin_gt is None:
                continue

            out.write(f"{sample_id}\t{chrom}\t{pos}\t{bin_gt}\n")
