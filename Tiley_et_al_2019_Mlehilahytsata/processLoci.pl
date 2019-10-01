#!/usr/bin/perl -w

open FH1,'<',"allSeqs.fasta";
system "mkdir loci";
#>CLocus_2_Sample_1_Locus_2_Allele_0 [AN-06-B]
%loci = ();
%seqs = ();
%taxa = ();
$thisLocus = 0;
while (<FH1>)
{
    if (/^>CLocus\_\d+\_Sample\_\d+\_Locus\_(\d+)\_Allele_(\d+)\s+\[(\S+)\]/)
    {
	$locus = $1;
	$allele = $2;
	$tax = $3;
	if (! exists $loci{$locus})
	{
	    if ($thisLocus > 0)
	    {
		open OUT1,'>',"loci/$thisLocus.fasta";
		foreach $TAXON (keys %taxa)
		{
		    if ($taxa{$TAXON} > 2)
		    {
			print "COPY EMERGENCY\n$thisLocus\t$TAXON\n$taxa{$TAXON}\n\n";
		    }
		    elsif ($taxa{$TAXON} <= 2)
		    {
			if ((exists $seqs{$TAXON}{0}) && (exists $seqs{$TAXON}{1}))
			{
			    $consensus = "";
			    $check = 1;
			    @s1 = ();
			    @s2 = ();
			    @s1 = split(//,$seqs{$TAXON}{0});
			    @s2 = split(//,$seqs{$TAXON}{1});
			    for $i (0..(scalar(@s1)-1))
			    {
#				print "$s1[$i]\t$s2[$i]\n";
				if (($s1[$i] eq "A") and ($s2[$i] eq "A"))
				{
				    $consensus = $consensus . "A";
				    $check = 0;
				}
				if (($s1[$i] eq "C") and ($s2[$i] eq "C"))
                                {
                                    $consensus = $consensus . "C";
				    $check = 0;
				}
				if (($s1[$i] eq "G") and ($s2[$i] eq "G"))
                                {
                                    $consensus = $consensus . "G";
				    $check = 0;
				}
				if (($s1[$i] eq "T") and ($s2[$i] eq "T"))
                                {
                                    $consensus = $consensus . "T";
				    $check = 0;
				}
				if (($s1[$i] eq "C" and $s2[$i] eq "T") or ($s1[$i] eq "T" and $s2[$i] eq "C"))
				{
                                    $consensus = $consensus . "Y";
				    $check = 0;
				}
				if (($s1[$i] eq "A" and $s2[$i] eq "G")or ($s1[$i] eq "G" and $s2[$i] eq "A"))
				{
                                    $consensus = $consensus . "R";
				    $check = 0;
				}
				if (($s1[$i] eq "A" and $s2[$i] eq "T")or ($s1[$i] eq "T" and $s2[$i] eq "A"))
				{
                                    $consensus = $consensus . "W";
				    $check = 0;
				}
				if (($s1[$i] eq "C" and $s2[$i] eq "G")or ($s1[$i] eq "G" and $s2[$i] eq "C"))
				{
                                    $consensus = $consensus . "S";
				    $check = 0;
				}
				if (($s1[$i] eq "G" and $s2[$i] eq "T")or ($s1[$i] eq "T" and $s2[$i] eq "G"))
				{
                                    $consensus = $consensus . "K";
				    $check = 0;
				}
				if (($s1[$i] eq "C" and $s2[$i] eq "A")or ($s1[$i] eq "A" and $s2[$i] eq "C"))
				{
                                    $consensus = $consensus . "M";
				    $check = 0;
				}
				if (($s1[$i] eq "A" and $s2[$i] eq "N")or ($s1[$i] eq "N" and $s2[$i] eq "A"))
                                {
                                    $consensus = $consensus . "N";
				    $check = 0;
				}
				if (($s1[$i] eq "C" and $s2[$i] eq "N")or ($s1[$i] eq "N" and $s2[$i] eq "C"))
				{
                                    $consensus = $consensus . "N";
				    $check = 0;
				}
				if (($s1[$i] eq "G" and $s2[$i] eq "N")or ($s1[$i] eq "N" and $s2[$i] eq "G"))
				{
                                    $consensus = $consensus . "N";
				    $check = 0;
				}
				if (($s1[$i] eq "T" and $s2[$i] eq "N")or ($s1[$i] eq "N" and $s2[$i] eq "T"))
				{
                                    $consensus = $consensus . "N";
				    $check = 0;
				}
				if ($s1[$i] eq "N" and $s2[$i] eq "N")
                                {
                                    $consensus = $consensus . "N";
				    $check = 0;
				}
				if ($check == 1)
				{
				    print "BASE EMERGENcY\n$thisLocus\t$TAXON\n$s1[$i]\t$s2[$i]\n\n";
				}
			    }
			    print OUT1 ">$TAXON\n$consensus\n";
			}
			elsif ((exists $seqs{$TAXON}{0}) && (! exists $seqs{$TAXON}{1}))
                        {
			    print OUT1 ">$TAXON\n$seqs{$TAXON}{0}\n";
			}
		    }
		}
		close OUT1;
	    }
	    $loci{$locus} = 1;
	    %seqs = ();
	    $thisLocus = $locus;
	    %taxa = ();
	    $taxa{$tax} = 1;
	}
	elsif (exists $loci{$locus})
	{
	    if (! exists $taxa{$tax})
	    {
		$taxa{$tax} = 1;
	    }
	    elsif (exists $taxa{$tax})
	    {
		$taxa{$tax} = $taxa{$tax} + 1;
	    }
	}
    }
    elsif (/(\S+)/)
    {
	$seq = $1;
	$seqs{$tax}{$allele} = $seq;
	if (length($seq) < 100)
	{
	    print "$seq\n";
	}
    }
}
close FH1;
