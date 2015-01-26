#!/usr/bin/perl
use warnings;

system 'ls *.codonalign.phy > PhyFiles';
open FH1, "<PhyFiles";
while (<FH1>)
{
    if (/((\S+)\.codonalign\.phy)/)
    {
	$File = $1;
	$Gene = $2;
	$Tree = "$Gene.tre";
	$OUT = "$Gene.H0.out";
	open OUT1, ">$Gene.H0.ctl";
	open FH2, "<H0.template.ctl";
	while (<FH2>)
	{
	    $Line = $_;
	    chomp $Line;
	    if ($Line =~ m/.+IAMTHESEQFILE.+/ || $Line =~ m/.+IAMTHETREEFILE.+/ || $Line =~ m/.+IAMTHERESULTSFILE.+/)
            {
		if ($Line =~ m/.+(IAMTHESEQFILE).+/)
		{
		    $SEQFILE = $1;
		    $Line =~ s/$1/$File/;
		    print OUT1 "$Line\n";
		}
		if ($Line =~ m/.+(IAMTHETREEFILE).+/)
		{
		    $SEQFILE = $1;
		    $Line =~ s/$1/$Tree/;
		    print OUT1 "$Line\n";
		} 
		if ($Line =~ m/.+(IAMTHERESULTSFILE).+/)
		{
		    $SEQFILE = $1;
		    $Line =~ s/$1/$OUT/;
		    print OUT1 "$Line\n";
		}
	    }
	    elsif ($Line !~ m/.+IAMTHESEQFILE.+/ && $Line !~ m/.+IAMTHETREEFILE.+/ && $Line !~ m/.+IAMTHERESULTSFILE.+/)
	    {
		print OUT1 "$Line\n";
	    }
	}
    }
}
close OUT1;
close FH2;
close FH1;
unlink "PhyFiles";
exit;
