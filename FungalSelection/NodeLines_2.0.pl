#!/usr/bin/perl
use warnings;

system 'ls *.tre > TreeFiles.list';
open FH1, "<TreeFiles.list";
while (<FH1>)
{
	if (/((\S+)\.tre)/)
	{
		$File = $1;
		$Gene = $2;
		open OUT1, ">$Gene.BreakTree.tre";
		open FH2, "$File";
		while (<FH2>)
		{
			$TreeString = $_;
			$TreeString =~ s/\(/\(\n/g;
			$TreeString =~ s/\)/\)\n/g;
			$TreeString =~ s/\,/\,\n/g;
		}
		print OUT1 "$TreeString\n";
	}
}
close FH1;
exit;