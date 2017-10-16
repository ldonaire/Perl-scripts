# Perl-scripts
Perl scripts to analyze smallRNAseq data from plant viruses

By Livia Donaire (CEBAS-CSIC)

# countfq_20to26.pl

Perl script to count sRNA sequences of 20 to 26 nts in length from a fastq file and to calculate the percentage of each sRNA size class comparing to the total number of sequences analyzed.

Usage: 

perl /path/countfq_20to26.pl <sequences.fastq>


# countfa_20to26.pl

Perl script to count sRNA sequences of 20 to 26 nts in length from a fasta file and to calculate the percentage of each sRNA size class comparing to the total number of sequences analyzed.

Usage: 

perl /path/countfa_20to26.pl <sequences.fasta>


# fqtofaunique.pl

Perl script to convert a sequence file in fastq format to fasta format and to collapse reads. Also it counts the number of each sRNA sequence and prints this number in the header of the fasta sequence.

Usage: 

perl /path/fqtofaunique.pl <sequences.fastq>

# misis_table_analysis.pl

Perl script to extract the number of total and unique vsRNAs mapping the virus genome by sizes and by strand orientation from the table file generated using MISIS (http://www.fasteris.com/apps/).

Usage 

perl /path/misis_table_analysis.pl <misis_table.txt>

# nucomp_fq.pl

Perl script to calculate the 5' end nucleotide composition of a pool of sRNA sequences in fastq format.

Usage: 

perl /path/nucomp_fq.pl <sequences.fastq>

# nucomp_fa.pl

Perl script to calculate the 5' end nucleotide composition of a pool of sRNA sequences in fasta format.

Usage: 

perl /path/nucomp_fq.pl <sequences.fasta>

# rna_to_dna.pl

Perl script to transform RNA sequences to DNA in a multifasta input file.

Usage: 

perl /path/rna_to_dna.pl <sequences.fasta>

# srna_count_comparison.pl

Perl script to print counting data from the eXpress output (https://pachterlab.github.io/eXpress/) of two different samples into a unique tab-delimited file and to calculate fold change and log2FC of the number of sRNAs mapping transcripts in these two samples.

Usage: perl /path/sRNA_count_comparison.pl <result_non-infected_sample.xprs> <result_infected_sample.xprs> <non-infected_id> <infected_id>

where,

<non-infected_id> is an user-defined name for the control sample without whitespaces

<infected_id> is an user-defined name for the infected sample without whitespaces
