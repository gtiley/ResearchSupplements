#/usr/bin/perl                                                                                                                                                   
use warnings;
system 'ls *.codonalign.fasta> codondatafiles.txt';
open FH1, "<codondatafiles.txt";

while (<FH1>)
{
    if (/((\S+)\.codonalign\.fasta)/)
    {
        $File = $1;
        $Gene = $2;
        @CqfTaxArray = ();
        @NotCqfTaxArray = ();
        @CqfNodeArray = ();
        @NotCqfTaxArray = ();
        
        open FH2, "$File";
        while (<FH2>)
        {
        	if (/>(Cqf\S+)/)
        	{
        		$CqfTax = $1;
        		push @CqfTaxArray, $CqfTax;
#        		print "Hi\n";
        	}
        	elsif (/>(\S+)/)
        	{
        		$NotCqfTax = $1;
        		push @NotCqfTaxArray, $NotCqfTax;
        	}
        }		
#        print "@CqfTaxArray\n";
		open FH4, "<$Gene.NodeList.txt";
		while (<FH4>)
		{
			if (/(ANTICQF_NODE\S+)/)
			{
				$NotCqfNode = $1;
				if ($NotCqfNode ne "NOTCQFNODE_0")
				{
					push @NotCqfNodeArray, $NotCqfNode;
				}
			}
			elsif (/(CQFNODE\S+)/) 
			{
				$CqfNode = $1;
				push @CqfNodeArray, $CqfNode;
			}
		}
		$NotCqfTax_N = scalar @NotCqfTaxArray;
		$CqfTax_N = scalar @CqfTaxArray;
		$NotCqfNode_N = scalar @NotCqfNodeArray;
		$CqfNode_N = scalar @CqfNodeArray;
		
		open OUT2, ">$Gene.ConstrainedNodes.H2.tre";
		open FH3, "<$Gene.NamedNodes.tre";
		while (<FH3>)
		{
	    	$tree = $_;
	    	chomp $tree;
	    	$tree =~ s/ANTICQF_NODE_0//;
	    	for (0..($CqfTax_N - 1))
	    	{
	    		$i = $_;
	    		print "$CqfTaxArray[$i]\n";
	    		$tree =~ s/$CqfTaxArray[$i]/$CqfTaxArray[$i] \#1/;
	    	}
	    	for (0..($NotCqfTax_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$NotCqfTaxArray[$i]/$NotCqfTaxArray[$i]/;
	    	}
	    	for (0..($CqfNode_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$CqfNodeArray[$i]/\#1/;
	    	}
	    	for (0..($NotCqfNode_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$NotCqfNodeArray[$i]//;
	    	}
		}
		print OUT2 "$tree";
		close OUT2;
		close FH3;
		close FH4;
		close FH2;
		
		$SeqFile = "$Gene.codonalign.phy";
		$Tree = "$Gene.ConstrainedNodes.H2.tre";
		$OUT = "$Gene.H2.out";
		open OUT1, ">$Gene.H2.ctl";
		open FH5, "<H2.template.ctl";
		while (<FH5>)
		{
	    	$Line = $_;
		    chomp $Line;
		    if ($Line =~ m/.+IAMTHESEQFILE.+/ || $Line =~ m/.+IAMTHETREEFILE.+/ || $Line =~ m/.+IAMTHERESULTSFILE.+/)
            {
				if ($Line =~ m/.+(IAMTHESEQFILE).+/)
				{
				    $SEQFILE = $1;
			    	$Line =~ s/$1/$SeqFile/;
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
close FH5;
close FH1;
unlink "codondatafiles.txt";
exit;