#!/usr/bin/env python3

vcf_file = "biallelic.vsf"
af_out = "AF.txt"
dp_out = "DP.txt"

af_key = None

for line in open("biallelic.vcf"):
    if not line.startswith("##INFO="):
        continue
    if "ID=AF," in line:
        af_key = "AF"
        break
    elif "allele" in line.lower() and "frequency" in line.lower():
        start = line.find("ID=") + 3
        end = line.find(",", start)
        af_key = line[start:end]
        break

if af_key is None:
    af_key = "AF"

af_values = []
dp_values = []

for line in open("biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    info_field = fields[7]
    info_dict = {}
    for item in info_field.split(';'):
        if '=' in item:
            key, value = item.split('=', 1)
            info_dict[key] = value

    af = None
    if af_key in info_dict:
        af = info_dict[af_key].split(',')[0]
    elif "AC" in info_dict and "AN" in info_dict:
        try:
            ac = float(info_dict["AC"].split(',')[0])
            an = float(info_dict["AN"])
            af = str(ac / an)
        except ZeroDivisionError:
            af = "NA"

    if af is None:
        af = "NA"

    af_values.append(af)

    format_field = fields[8]
    sample_fields = fields[9:]

    format_keys = format_field.split(':')
    if "DP" not in format_keys:
        dp_index = None
        for key in format_keys:
            if "depth" in key.lower():
                dp_index = format_keys.index(key)
                break
    else:
        dp_index = format_keys.index("DP")

    if dp_index is not None:
        for sample_entry in sample_fields:
            sample_values = sample_entry.split(':')
            if len(sample_values) > dp_index:
                dp = sample_values[dp_index]
            else:
                dp = "NA"
            dp_values.append(dp)
    else:
        dp_values.extend(["NA"] * len(sample_fields))
    

# Write outputs
with open(af_out, "w") as af_file:
    af_file.write("AF\n")
    for val in af_values:
        af_file.write(val + "\n")

with open(dp_out, "w") as dp_file:
    dp_file.write("DP\n")
    for val in dp_values:
        dp_file.write(val + "\n")
