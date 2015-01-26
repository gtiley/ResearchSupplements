#!/usr/bin/perl
use warnings;

system 'ls *.codonalign.fasta > CodonFiles.list';
open FH1, "<CodonFiles.list";
%GeneCqfHash = ();
%GeneTaxHash = ();
while (<FH1>)
{
    if (/((\S+)\.codonalign\.fasta)/)
    {
	$CodonFile = $1;
	$Gene = $2;
	@TaxArray = ();
	open FH2, "$CodonFile";
	while (<FH2>)
	{
	    if (/>(\S+)/)
	    {
		$Tax = $1;
		push @TaxArray, $Tax;
	    }
	}
	$CqfCount = 0;
	$TaxCount = 0;
	foreach $TAX (@TaxArray)
	{
	    $TaxCount = $TaxCount + 1;
	    if ($TAX =~ m/Cqf.+/g)
	    {
		$CqfCount = $CqfCount + 1;
	    }
	}
	$GeneCqfHash{$Gene} = $CqfCount;
	$GeneTaxHash{$Gene} = $TaxCount;
    }
}

foreach $GENE (keys %GeneCqfHash)
{
    if ($GeneCqfHash{$GENE} == 0)
    {
	unlink "$GENE.codonalign.fasta";
	unlink "$GENE.treefix.ED.tre";
    }
    if ($GeneTaxHash{$GENE} == $GeneCqfHash{$GENE})
    {
	unlink "$GENE.codonalign.fasta";
        unlink "$GENE.tre";
    }
}
close FH2;
close FH1;
exit;
