#######################################
Performance comparison D, Julia, Python
#######################################

Count sequences and average sequence length in FASTA
====================================================
Count the number of sequences and the average sequence length in GenBank nt in
FASTA format. All times were measured with bash's built in "time".

Timings GenBank nt
------------------
Timings on runs performed on Terra.

      Dlang      Dlang(-O)   Julia       Python   
      4m12.492s  3m35.004s   3m20.989s   7m18.051s
      4m18.651s  3m34.816s   3m12.535s   7m17.147s
      3m50.842s  3m34.976s   2m56.424s   7m15.199s

Mean: 4m07s      3m35s       3m10s       7m17s
Stdv: 15s        0s          12s         1s


Timings MH0026.seq.fa (Qin et al. 2010)
---------------------------------------
Timings of runs performed on Terra. Averages of three runs after the file has
entered the file system cache. No optimization of the Python script was
performed.

        Default  Optimized
Dlang:  ~0.07s   ~0.06s
Julia:  ~1.2s    ~0.19s
Python: ~0.09s  


Code metrics
------------
How many lines of code (LOC) and how long did it take to write the code (TTW),
including debugging and making sure it produces the correct results.

     Dlang  Julia  Python
LOC: 39     26     34
TTW: 10m    15m    <5m


Comments:
---------
Dlang
.....
I'm not readily familiar with the standard library of D and I needed to
check a few things in the documentation. The D standard library does not appear
to have any simple way of reading gzipped files iteratively. I skipped on that
functionality in this script. If the program is run as a script using 'rdmd'
the D program it is compiled and cached. This is important to note and all
timings above where done with the compiled cache.

If the D program is compiled with DMD (reference compiler implementation) using
the -O flag to enable optimization, the timings are better but still not better
than the Julia program..

Julia
.....
I have _very_ little experience writing code in Julia and know almost
nothing of the syntax. I had to check up syntax for every line of code I wanted
to write essentially. The FastaIO package is very nice and looks like it shares
some of my ideas on what a good FASTA reader package would look like. The Julia
script can read a gzipped fasta file transparently. 

Julia looks good when running on GenBank nt, however it is the slowest when
running on smaller files like MH0026.seq.fa (67MB) from Qin et al (2010). This
is because of the JIT compiler that does not cache the compiled code in between
runs.  Running the 'read_fasta' function inside the script with the '@time'
macro shows that the time to run the optimized function is probably closer to
0.19s.

Python
......
I'm very comfortable and familiar with Python and writing and debugging
scripts just like this is something I do regularly. I did not need to check the
documentation once for the Python script. The Python script can read a gzipped
fasta file transparently.



Appendix: Data
==============

CSV timings data
----------------
Dlang,Julia,Python
4m12.492s,3m20.989s,7m18.051s
4m18.651s,3m12.535s,7m17.147s
3m50.842s,2m56.424s,7m15.199s

Raw terminal paste 
------------------
$ time ./count_fasta.d /shared/genbank/nt
20742513 2515.34

real    4m12.492s
user    3m44.999s
sys     0m22.772s

$ time ./count_fasta.d /shared/genbank/nt
20742513 2515.34

real    4m18.651s
user    3m45.289s
sys     0m21.028s

$ time ./count_fasta.jl /shared/genbank/nt
20742513 2515.3359845067953

real    3m20.989s
user    2m49.856s
sys     0m18.556s

$ time ./count_fasta.jl /shared/genbank/nt
20742513 2515.3359845067953

real    3m12.535s
user    2m49.786s
sys     0m15.390s

$ time ./count_fasta.py /shared/genbank/nt
20742513 2515.33598451

real    7m16.051s
user    7m3.277s
sys     0m11.546s

$ time ./count_fasta.py /shared/genbank/nt
20742513 2515.33598451

real    7m17.147s
user    7m5.201s
sys     0m10.898s

$ time ./count_fasta.d /shared/genbank/nt
20742513 2515.34

real    3m50.842s
user    3m39.555s
sys     0m10.695s

$time ./count_fasta.jl /shared/genbank/nt
20742513 2515.3359845067953

real    2m56.424s
user    2m43.127s
sys     0m14.346s

$ time ./count_fasta.py /shared/genbank/nt
20742513 2515.33598451

real    7m15.199s
user    7m2.952s
sys     0m11.224s