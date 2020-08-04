#!/usr/bin/perl -w

@alignments = glob("../../neutralFasta/noncoding/*.fasta");
foreach $ff (@alignments)
{
    if ($ff =~ m/\.\.\/\.\.\/neutralFasta\/noncoding\/(\S+)\.fasta/)
    {
	$id = $1;
	%seqs = ();
	$nsites = 0;
	open OUT1,'>',"$id.fasta";
	open FH1,'<',"$ff";
	while(<FH1>)
	{
	    if (/^>(\S+)\.\S+/)
	    {
		$tax = $1;
	    }
	    elsif (/(\S+)/)
	    {
		$seq = $1;
		@temp = ();
		@temp = split(//,$seq);
		for $i (0..(scalar(@temp)-1))
		{
		    push @{$seqs{$tax}},$temp[$i];
		}
		if ($nsites == 0)
		{
		    $nsites = scalar(@temp);
		}
	    }
	}
	close FH1;
	@missing = ();
	for $i (0..($nsites - 1))
	{
	    $miss = 0;
	    foreach $tax (sort keys %seqs)
	    {
		if ($seqs{$tax}[$i] ne "N" and $seqs{$tax}[$i] ne "-")
		{
		    $miss++;
		}
	    }
	    if ($miss == 0)
	    {
		$missing[$i] = 1;
	    }
	    elsif ($miss > 0)
	    {
		$missing[$i] = 0;
	    }
	}
	foreach $tax (sort keys %seqs)
	{
	    print OUT1 ">$tax\n";
	    for $i (0..($nsites - 1))
	    {
		if ($missing[$i] == 0)
		{
		    print OUT1 "$seqs{$tax}[$i]";
		}
	    }
	    print OUT1 "\n";
	}
	close OUT1;
    }
}
exit;
