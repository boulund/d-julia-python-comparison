#!/usr/bin/env rdmd 
// Written in the D language
// Fredrik Boulund 2014-06-14
// Counts number of sequences and their average length

import std.string; // chomp
import std.stdio; // writeln, writefln etc.

void printHelp() {
	writeln("usage: count_fasta.d FILE");
	writeln("Counts number of sequences and their average length.");
}

void parseFasta(string filename) {
	ulong numrec, seqlen, totlen;

	foreach(line; filename.File.byLine) {
		if (line[0] == '>') {
            numrec++;
            totlen += seqlen;
            seqlen = 0;
		} else {
			seqlen = seqlen + chomp(line).length;
		}
	}
    totlen += seqlen;
    auto avg = cast(float) totlen/numrec;

	writefln("%s %s", numrec, avg);
}

int main(string[] args) {
	if (args.length < 2) {
		printHelp();
		return 1;
	}
	parseFasta(args[1]);
	return 0;
}
