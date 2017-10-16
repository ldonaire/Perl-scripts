#! /usr/bin/perl

# Perl script to extract the number of total and unique vsRNAs mapping the virus genome by sizes and 
# by strand orientation from the table file generated using MISIS (http://www.fasteris.com/apps/).

use strict;
#use warnings;

# check for proper input parameters 
unless ($ARGV[0]) {
  die "Usage: perl $0 <misis_table.txt>\n";
}

# open input tab-delimited file
my $infile = $ARGV[0];
open (IN,"<$infile") || die "Cannot open input file $infile: $!";

# global variables:
my ($totf20,$totf21,$totf22,$totf23,$totf24,$totf25,$totf26,$totr20,$totr21,$totr22,$totr23,$totr24,$totr25,$totr26,$totf,$totr,$sumt)=0;

my ($conf20,$conf21,$conf22,$conf23,$conf24,$conf25,$conf26,$conr20,$conr21,$conr22,$conr23,$conr24,$conr25,$conr26,$conf,$conr,$sumc)=0;

my ($pf20t, $pf21t, $pf22t, $pf23t, $pf24t, $pf25t, $pf26t, $pr20t, $pr21t, $pr22t, $pr23t, $pr24t, $pr25t, $pr26t, $pft, $prt) = 0;

my ($pf20u, $pf21u, $pf22u, $pf23u, $pf24u, $pf25u, $pf26u, $pr20u, $pr21u, $pr22u, $pr23u, $pr24u, $pr25u, $pr26u, $pfu, $pru) = 0;

# doing the work

while (<IN>) {
	chomp;
	next if (m/position/); #remove the header line of the input file
	my ($pos,$f20,$f21,$f22,$f23,$f24,$f25,$f26,$r20,$r21,$r22,$r23,$r24,$r25,$r26,$f,$r,$sum)= split(/\t/); #load each column of the input file in a variable

# calculating total reads per vsRNA size and orientation
$totf20 += $f20, $totf21 += $f21,$totf22 += $f22, $totf23 += $f23, $totf24 += $f24, $totf25 += $f25, $totf26 += $f26, $totr20 += $r20, $totr21 += $r21, $totr22 += $r22, $totr23 += $r23, $totr24 += $r24, $totr25 += $r25, $totr26 += $r26, $totf += $f, $totr += $r, $sumt += $sum;

# calculating unique sequences per vsRNA size and orientation
	if ($f20>0){
		$conf20++;
	}if ($f21>0){
		$conf21++;
	}if ($f22>0){
		$conf22++;
	}if ($f23>0){
		$conf23++;
	}if ($f24>0){
		$conf24++;
	}if ($f25>0){
		$conf25++;
	}if ($f26>0){
		$conf26++;
	}if ($r20>0){
		$conr20++;
	}if ($r21>0){
		$conr21++;
	}if ($r22>0){
		$conr22++;
	}if ($r23>0){
		$conr23++;
	}if ($r24>0){
		$conr24++;
	}if ($r25>0){
		$conr25++;
	}if ($r26>0){
		$conr26++;
	}
	$conf=($conf20+$conf21+$conf22+$conf23+$conf24+$conf25+$conf26);
	$conr=($conr20+$conr21+$conr22+$conr23+$conr24+$conr25+$conr26);
	$sumc=($conf+$conr);

# calculating percentages per vsRNA size and orientation
# total sense and antisense
$pf20t=$totf20/$totf*100, $pf21t=$totf21/$totf*100, $pf22t=$totf22/$totf*100, $pf23t=$totf23/$totf*100, $pf24t=$totf24/$totf*100, $pf25t=$totf25/$totf*100, $pf26t=$totf26/$totf*100, $pr20t=$totr20/$totr*100, $pr21t=$totr21/$totr*100, $pr22t=$totr22/$totr*100, $pr23t=$totr23/$totr*100, $pr24t=$totr24/$totr*100, $pr25t=$totr25/$totr*100, $pr26t=$totr26/$totr*100;

# unique sense and antisense
$pf20u=$conf20/$conf*100, $pf21u=$conf21/$conf*100, $pf22u=$conf22/$conf*100, $pf23u=$conf23/$conf*100, $pf24u=$conf24/$conf*100, $pf25u=$conf25/$conf*100, $pf26u=$conf26/$conf*100, $pr20u=$conr20/$conr*100, $pr21u=$conr21/$conr*100, $pr22u=$conr22/$conr*100, $pr23u=$conr23/$conr*100, $pr24u=$conr24/$conr*100, $pr25u=$conr25/$conr*100, $pr26u=$conr26/$conr*100;
}

#print calculations in the STDOUT

print  "#### sense vsRNAs ####\n";
print  "length\ttotal \tpercentage\tunique\tpercentage\n";
print  "20 nts\t$totf20\t$pf20t\t$conf20\t$pf20u\n";
print  "21 nts\t$totf21\t$pf21t\t$conf21\t$pf21u\n";
print  "22 nts\t$totf22\t$pf22t\t$conf22\t$pf22u\n";
print  "23 nts\t$totf23\t$pf23t\t$conf23\t$pf23u\n";
print  "24 nts\t$totf24\t$pf24t\t$conf24\t$pf24u\n";
print  "25 nts\t$totf25\t$pf25t\t$conf25\t$pf25u\n";
print  "26 nts\t$totf26\t$pf26t\t$conf26\t$pf26u\n";
print  "sum\t$totf\t\t$conf\n";
print  "#### antisense vsRNAs ####\n";
print  "length\ttotal\tpercentage\tunique\tpercentage\n";
print  "20 nts\t$totr20\t$pr20t\t$conr20\t$pr20u\n";
print  "21 nts\t$totr21\t$pr21t\t$conr21\t$pr21u\n";
print  "22 nts\t$totr22\t$pr22t\t$conr22\t$pr22u\n";
print  "23 nts\t$totr23\t$pr23t\t$conr23\t$pr23u\n";
print  "24 nts\t$totr24\t$pr24t\t$conr24\t$pr24u\n";
print  "25 nts\t$totr25\t$pr25t\t$conr25\t$pr25u\n";
print  "26 nts\t$totr26\t$pr26t\t$conr26\t$pr26u\n";
print  "sum\t$totr\t\t$conr\n\n";
print  "both\t$sumt\t\t$sumc\n";

exit;
#############################################
