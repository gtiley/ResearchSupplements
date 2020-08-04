#!/usr/bin/perl -w

%seqs = ();
$nsites = 0;
open FH1,'<',"Mmur.noncpg.phy";
while (<FH1>)
{
    if (/\d+\s+\d+/)
    {

    }
    elsif (/(\S+)\s+(\S+)/)
    {
	$tax = $1;
	$seq = $2;
	$seqs{$tax} = $seq;
	if ($nsites == 0)
	{
	    $nsites = length($seq);
	}
    }
}
close FH1;
#387018
for $i (0..9)
{
    $nstart = int(rand(($nsites - 1000000)));
    print "$i\t$nstart\n";
    open OUT1,'>',"mn.$i.phy";
    print OUT1 "7  1000000\n";
    foreach $tax (sort keys %seqs)
    {
	$chunk = substr($seqs{$tax},$nstart,1000000);
	print OUT1 "$tax  $chunk\n";
    }
    close OUT1;
}
exit;
