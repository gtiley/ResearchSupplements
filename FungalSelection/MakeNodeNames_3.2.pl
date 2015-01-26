#!/usr/bin/perl
use warnings;

##
#Uses differently broken trees
#Goes from NodeLines2.0
##
system 'ls *.BreakTree.tre > NodeTreeList.list';
open FH1, "<NodeTreeList.list";
while (<FH1>)
{
	if (/((\S+)\.BreakTree\.tre)/)
	{
		$File = $1;
		$Gene = $2;
		open OUT1, ">$Gene.NamedNodes.tre";
		open OUT2, ">$Gene.NodeList.txt";
		open FH2,"$File";
		$CQF_NodeCount = 0;
        $NotCQF_NodeCount = 0;
        @LineArray = ();
		while (<FH2>)
		{
			$Line = $_;
			chomp $Line;
			push @LineArray, $Line;		
		}	
		$EndLine = (scalar @LineArray - 1);
		@LineArrayCopy = @LineArray;
		for (0..($EndLine))
		{	
			$i = $_;	
			$ParenthesesToClose = 1;				
				$LineIncrement = 1;	
			if ($LineArray[$i] =~ m/.*\(/)
			{
				while ($ParenthesesToClose != 0)
				{		
					if ($LineArray[$i + $LineIncrement] =~ m/.*\(.*/)
					{
						$ParenthesesToClose = $ParenthesesToClose + 1;
					}
					elsif ($LineArray[$i + $LineIncrement] =~ m/.*\).*/)
					{
						$ParenthesesToClose = $ParenthesesToClose - 1;
					}		
					$LineIncrement = ($LineIncrement + 1);	
				}
				if ($ParenthesesToClose == 0)
				{
					$CladeTaxCount = 0;
					$CladeCqfCount = 0;
					for ($i..($i + ($LineIncrement-1)))
					{
						$j = $_;
						@ShortList = split /,/, $LineArray[$j];
						foreach $Chars (@ShortList)
						{
							if ($Chars =~ m/(.*\w+.*)/)
							{	
								$CladeTaxCount = $CladeTaxCount + 1;
							}
							if ($Chars =~ m/Cqf\S+/)
							{
								$CladeCqfCount = $CladeCqfCount + 1;
							}
						}
					}
					if ($CladeTaxCount > 0)
					{
						if ($CladeTaxCount == $CladeCqfCount)
						{
							print OUT2 "CQFNODE\_$CQF_NodeCount\n";
							$LineArrayCopy[$i + ($LineIncrement-1)] =~ s/\)/\)CQFNODE\_$CQF_NodeCount/;
				  			$CQF_NodeCount = $CQF_NodeCount + 1;
	   					}		
						if ($CladeTaxCount != $CladeCqfCount)
	   					{
	   						print OUT2 "NOTCQFNODE\_$NotCQF_NodeCount\n";
							$LineArrayCopy[$i + ($LineIncrement-1)] =~ s/\)/\)NOTCQFNODE\_$NotCQF_NodeCount/;
				 			$NotCQF_NodeCount = $NotCQF_NodeCount + 1;
	   					}	
					}
				}
			}
		}
	}
	for (0..($EndLine))
	{
		$I = $_;
		print OUT1 "$LineArrayCopy[$I]";
	}	
}							
close FH2;
close FH1;
close OUT1;
exit;					
				
