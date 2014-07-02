#!/usr/bin/env julia
# Fredrik Boulund
# 2014-07-02
# Read a (compressed) FASTA file and count sequences and their lengths

using FastaIO

function read_fasta(filename::String)
    # Read a FASTA file iteratively and count the number 
    # of sequences and their respective lengths. 
    # The file can be gzipped.
    totlen = 0

    fr = FastaReader(filename)
    for (header, seq) in fr
        totlen += length(seq)
    end
    numseq = fr.num_parsed
    avg = totlen/numseq
    println("$numseq $avg")
end

read_fasta(ARGS[1])
