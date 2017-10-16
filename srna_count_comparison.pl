#! /usr/bin/perl

# Perl script to print counting data from the eXpress output (https://pachterlab.github.io/eXpress/) of two different samples into a unique tab-delimited file 
# and to calculate fold change and log2FC of the number of sRNAs mapping transcripts in these two samples.

use strict;
use warnings;

# checking arguments
unless ($ARGV[1]) {
die "Usage: perl $0 <result_non-infected_sample.xprs> <result_infected_sample.xprs> non-infected_id infected_id\n";
}

# open input tab-delimited files
my $infile1 = $ARGV[0];
open (IN1,"<$infile1") || die "Cannot open input file from non-infected sample $infile1\n";

my $infile2 = $ARGV[1];
open (IN2, "<$infile2") || die "Cannot open input file from infected sample $infile2\n";

# checking options
my $opt1=$ARGV[2];
my $opt2=$ARGV[3];

# Option sample id must be a string 
unless($opt1 =~ /\S/) {
	die "FATAL: Invalid entry. Please give a name for the non-infected sample (only allowed non-whitespace characters)\n";
}

unless($opt2 =~ /\S/) {
	die "FATAL: Invalid entry. Please give a name for the infected sample (only allowed non-whitespace characters)\n";
}

my $sample1=$opt1;
my $sample2=$opt2;

# create output file in csv format
my $out = $sample1 . '&' . $sample2 . '_comparison.csv';
open (OUT, ">$out") || die "Cannot create output file $out: $!"; 

# print the header of the output file
print OUT "transcript_id\ttranscript_length\t#_of_sRNAs_mappings_in_$sample1\t#_of_sRNAs_mappings_in_$sample2\tFold_change($sample2:$sample1)\t2logFC\n";

# do the work 

# sort each input file by column 2 ("transcript_id") using the Unix command "sort"
my $sortfile1 = 'sample1_sorted.csv';
system ("sort -k 2 $infile1 >$sortfile1");

my $sortfile2 = 'sample2_sorted.csv';
system ("sort -k 2 $infile2 >$sortfile2");

# join the two sorted files by column 2 "transcript_id" and print only columns 2, 3 and 5 from file 1 and column 5 from file 2 using the Unix command "join"
my $joinfile = $sample1 . 'JOIN' .$sample2 . '.csv';
system ("join -a1 -a2 -1 2 -2 2 -o 0 1.2 1.3 1.5 2.5 -e '0' $sortfile1 $sortfile2 >$joinfile");

### analysis of the joined file ###

# open the joined file using perl
open (IN3,"<$joinfile") || die "Cannot open $joinfile:$!";

# global variables:
my ($totalseq , $total0, $total1 , $total2 , $totalB , $sum , $foldchange , $log2FC) = 0;

print "######################################################################\n";
while (<IN3>) {
	chomp;
	next if (m/target_id/); #remove the header line of the $joinfile
	$totalseq++; # get the number of total transcript sequences analyzed
	my ($transcript_id1, $transcript_id2, $length, $count1, $count2) = split (/ /); # load each column of the $joinfile  separated by a whitespace in a variable

# number of genes without sRNA mappings in both samples
	if (($count1 == 0) && ($count2 == 0)) {
	$total0++;
	$foldchange = "NA";
	$log2FC = "NA";
	}

# number of genes with sRNA mapping only in sample 1 (non-infected) 
	if (($count1 > 0) && ($count2 == 0)) {
	$total1++;
	$foldchange = "NA";
	$log2FC = "NA";
	}

# number of genes with sRNA mapping only in sample 2 (infected) 
	if (($count1 == 0) && ($count2 > 0)) {
	$total2++;
	$foldchange = "NA";
	$log2FC = "NA";
	}

# calculate the ratio and log2FC only when there are sRNA mappings in both samples 
	if (($count1 > 0) && ($count2 > 0)) {
	$totalB++;	
	$foldchange = $count2 / $count1;	
	$log2FC = log($foldchange)/log(2); #is the same than log2($count2)-log2($count1)
	}

# print the results to the output file
	if ($transcript_id1 eq $transcript_id2) {
	print OUT "$transcript_id1\t$length\t$count1\t$count2\t$foldchange\t$log2FC\n";
	}
}

$sum = $total0 + $total1 + $total2 + $totalB; #Total sequences analyzed (should be equal than $totalseq)
#print log data to the STDOUT
print "Number of transcripts analyzed: $totalseq\n";
print "Number of transcripts without sRNAs mapping any sample, $sample1 and $sample2: $total0\n";
print "Number of transcripts with sRNAs mapping only to sample $sample1: $total1\n";
print "Number of transcripts with sRNAs mapping only to sample $sample2: $total2\n";
print "Number of transcripts with sRNAs mapping to both samples: $totalB\n";
print "####################################################################\n\n";
if ($sum == $totalseq) {
	print "The job finished without any problem, congratulations!\n";
	} else {
	print "Sorry, something was wrong! The number of transcripts analyzed ($totalseq) is different than the number of transcipts with or whitout sRNAs mapping to each or to both samples ($sum). Please, check the code or the format of the input files\n";
}

# remove temporary files:
unlink ($sortfile1, $sortfile2, $joinfile);

# close files
close IN1;
close IN2;
close IN3;
close OUT;
	
exit;
#############################################
