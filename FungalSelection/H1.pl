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
        $Tree = "$Gene.NamedNodes.tre";
        @CqfTaxArray = ();
        @NotCqfTaxArray = ();
        @CqfNodeArray = ();
        @NotCqfNodeArray = ();
        @CqfMax = ();
        
        open FH2, "$File";
        while (<FH2>)
        {
        	if (/>(Cqf\S+)/)
        	{
        		$CqfTax = $1;
        		push @CqfTaxArray, $CqfTax;
        	}
        	elsif (/>(\S+)/)
        	{
        		$NotCqfTax = $1;
        		push @NotCqfTaxArray, $NotCqfTax;
        	}
        }		
		open FH4, "<$Gene.NodeList.txt";
		while (<FH4>)
		{
			if (/(ANTICQF_NODE\S+)/)
			{
				$NotCqfNode = $1;
				if ($NotCqfNode ne "ANTICQF_NODE_0")
				{
					push @NotCqfNodeArray, $NotCqfNode;
				}
			}
			elsif (/(CQFNODE\S+)/) 
			{
				$CqfNode = $1;
				push @CqfNodeArray, $CqfNode;
				open FH99, "$Tree";
				while (<FH99>)
				{
					$treestring = $_;
					chomp $treestring;
					@treechars = ();
					@treechars = split//, $treestring;
					$Nchars = scalar @treechars;
					$start = index($treestring, $CqfNode);
					$end = $start + length($CqfNode) - 1;		
					if ($treechars[$end + 1] eq ")")
					{
						if ($treechars[$end + 2] eq "C"){if ($treechars[$end + 3] eq "Q"){if ($treechars[$end + 4] eq "F"){if ($treechars[$end + 5] eq "N"){if ($treechars[$end + 6] eq "O"){if ($treechars[$end + 7] eq "D"){if ($treechars[$end + 8] eq "E")
						{
							#This Node is not a max clade, so leave it be
						}}}}}}}
						if ($treechars[$end + 2] ne "C"){if ($treechars[$end + 3] ne "Q"){if ($treechars[$end + 4] ne "F"){if ($treechars[$end + 5] ne "N"){if ($treechars[$end + 6] ne "O"){if ($treechars[$end + 7] ne "D"){if ($treechars[$end + 8] ne "E")
						{
							#This Node is Max!
							push @CqfMax, $CqfNode;
							#And remove from the main node array, it will be the last element
							pop @CqfNodeArray;
						}}}}}}}
					}
					elsif ($treechars[$end + 1] ne ")")
					{
						#Explore the space
						if ($treechars[$end + 1] eq "," and $treechars[$end + 2] eq "C" and $treechars[$end + 3] eq "q" and $treechars[$end + 4] eq "f")
						{
							#Not a max node
						}
						elsif ($treechars[$end + 1] eq "," and $treechars[$end + 2] ne "C" and $treechars[$end + 3] ne "q" and $treechars[$end + 4] ne "f")
						{
							$Nodes_To_Close = 0;
							$Satisfaction = 0;
							for (0..($Nchars - $end - 1))
							{
								$i = $_;
								if ($Satisfaction != 1)
								{
									if ($treechars[$end + $i] eq ")" && $Nodes_To_Close ==0)
									{
										if ($treechars[$end + $i + 1] ne "C"){if ($treechars[$end + $i + 2] ne "Q"){if ($treechars[$end + $i + 3] ne "F"){if ($treechars[$end + $i + 4] ne "N"){if ($treechars[$end + $i + 5] ne "O"){if ($treechars[$end + $i + 6] ne "D"){if ($treechars[$end + $i + 7] ne "E")
										{
											push @CqfMax, $CqfNode;
											pop @CqfNodeArray;
											$Satisfaction++;
										}
										}}}}}}
										if ($treechars[$end + $i + 1] eq "C"){if ($treechars[$end + $i + 2] eq "Q"){if ($treechars[$end + $i + 3] eq "F"){if ($treechars[$end + $i + 4] eq "N"){if ($treechars[$end + $i + 5] eq "O"){if ($treechars[$end + $i + 6] eq "D"){if ($treechars[$end + $i + 7] eq "E")
										{
											# The node we are looking at is not a max clade node
										}
										}}}}}}
										if ($treechars[$end + $i] eq ")" && $Nodes_To_Close !=0)
										{
											$Nodes_To_Close = $Nodes_To_Close - 1;
										}
										if ($treechars[$end + $i] eq "(")
										{
											$Nodes_To_Close = $Nodes_To_Close + 1;
										}
									}	
								}
							}
						}
					}
				}	
				close FH99;			
			}
		}
			$NotCqfTax_N = scalar @NotCqfTaxArray;
			$CqfTax_N = scalar @CqfTaxArray;
			$NotCqfNode_N = scalar @NotCqfNodeArray;
			$CqfNode_N = scalar @CqfNodeArray;
			$CqfMax_N = scalar @CqfMax;
		
		open OUT2, ">$Gene.ConstrainedNodes.H1.tre";
		open FH3, "<$Gene.NamedNodes.tre";
		while (<FH3>)
		{
	    	$tree = $_;
	    	chomp $tree;
	    	$tree =~ s/ANTICQF_NODE_0//;
	    	for (0..($CqfTax_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$CqfTaxArray[$i]/$CqfTaxArray[$i]/;
	    	}
	    	for (0..($NotCqfTax_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$NotCqfTaxArray[$i]/$NotCqfTaxArray[$i]/;
	    	}
	    	for (0..($CqfNode_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$CqfNodeArray[$i]//;
	    	}
	    	for (0..($NotCqfNode_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$NotCqfNodeArray[$i]//;
	    	}
	    	for (0..($CqfMax_N - 1))
	    	{
	    		$i = $_;
	    		$tree =~ s/$CqfMax[$i]/\#1/;
	    	}
		}
		print OUT2 "$tree";
		close OUT2;
		close FH3;
		close FH4;
		close FH2;
		
		$SeqFile = "$Gene.codonalign.phy";
		$Tree = "$Gene.ConstrainedNodes.H1.tre";
		$OUT = "$Gene.H1.out";
		open OUT1, ">$Gene.H1.ctl";
		open FH5, "<H1.template.ctl";
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