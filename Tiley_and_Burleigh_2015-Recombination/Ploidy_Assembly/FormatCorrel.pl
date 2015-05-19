#!/usr/bin/perl
use warnings;

open FH1, "<cM_C.Mb.PermutationResults.txt";
open OUT1, ">CM_C.Mb.meta.txt";
$num = 0;
while(<FH1>)
{
	$Line = $_;
	chomp $Line;
	$num++;
	if ($Line =~ m/.+HERE\s+(\S+)/)
	{
		$Correl = $1;
		print OUT1 "$Correl\t28\t$num\n";
	}
}
exit;	