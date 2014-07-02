#!/usr/bin/env julia
# Fredrik Boulund
# 2014-07-02
# Read a (compressed) FASTA file and count sequences and their lengths

using FastaIO

function read_fasta(filename::String)
    # Read a FASTA file iteratively and count the number 
    # of sequences and their respective lengths. 
    # The file can be gzipped.
    numseq = 0
    seqlen = 0 
    totlen = 0

    fr = FastaReader(filename)
    for (header, seq) in fr
        numseq += 1
        seqlen += length(seq)
    end
    avg = seqlen/numseq
    println("$numseq $avg")
end

@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])
@time read_fasta(ARGS[1])

