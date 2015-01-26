#!/usr/bin/perl
use warnings;

system 'ls *.tre > TreeFiles.list';
open FH9, "<TreeFiles.list";
while (<FH9>)
{
	if (/((\S+)\.tre)/)
	{
		$File = $1;
		$Gene = $2;
		open OUT9, ">$Gene.BreakTree.tre";
		open FH8, "$File";
		while (<FH8>)
		{
			$TreeString = $_;
			$TreeString =~ s/\(/\(\n/g;
			$TreeString =~ s/\)/\)\n/g;
			$TreeString =~ s/\,/\,\n/g;
		}
		print OUT9 "$TreeString\n";
	}
}
close FH1;

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
	   						print OUT2 "ANTICQF_NODE\_$NotCQF_NodeCount\n";
							$LineArrayCopy[$i + ($LineIncrement-1)] =~ s/\)/\)ANTICQF_NODE\_$NotCQF_NodeCount/;
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

open FH1, "<NodeTreeList.list";
while (<FH1>)
{
	if (/((\S+)\.BreakTree\.tre)/)
	{
		$File = $1;
		unlink "$File";
	}
}
unlink "NodeTreeList.list";
unlink "TreeFiles.list";
close FH1;
exit;					
				
