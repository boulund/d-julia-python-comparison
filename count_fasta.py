#!/usr/bin/env python
# Counts number of sequences and their average length
# Fredrik Boulund 2013-09-10

from __future__ import division
from sys import argv, exit
import gzip

if len(argv)<2:
    print "Reads FASTA (incl. gzipped) file and counts number of sequences and their average length."
    print "Usage: script.py FILE"
    exit()

numseq = 0
lenseq = 0
totlen = 0

for file in argv[1:]:
    if file.endswith(("gz","GZ")):
        f = gzip.open(file)
    else: 
        f = open(file)

    for line in f:
        if line.startswith(">"):
            numseq += 1
            totlen += lenseq
            lenseq = 0
        else:
            lenseq += len(line.strip())
    totlen += lenseq
    f.close()

    print numseq, totlen/numseq
