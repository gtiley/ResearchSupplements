#!/usr/bin/perl -w

$runid = $ARGV[0];
$globber = "*" . "$runid" . ".fasta";

%cdsCoords = ();
%chrList = ();
open FH1,'<',"ensGeneGTF.exons.hg38";
while(<FH1>)
{
    if (/(\S+)\s+(\S+)\s+(\S+)/)
    {
	$chr = $1;
	$start = $2;
	$stop = $3;
	$chr =~ s/chr//g;
	if (! exists $chrList{$chr})
	{
	    $chrList{$chr} = 1;
	}
	push @{$cdsCoords{$chr}{start}}, $start;
	push @{$cdsCoords{$chr}{stop}}, $stop;
    }
}
close FH1;

%cpgCoords = ();
%cpgSites = ();
open FH1,'<',"cpgIslands.hg38";
while(<FH1>)
{
    if (/(\S+)\s+(\S+)\s+(\S+)/)
    {
        $chr = $1;
        $start = $2;
        $stop = $3;
	$chr =~ s/chr//g;
        push @{$cpgCoords{$chr}{start}}, $start;
        push @{$cpgCoords{$chr}{stop}}, $stop;
	for $i ($start..$stop)
	{
	    if (! exists $cpgSites{$chr}{$i})
	    {
		$cpgSites{$chr}{$i} = 1;
	    }
	}
    }
}
close FH1;


@fastaFiles = glob("../fasta/$globber");
foreach $ff (@fastaFiles)
{
    if ($ff =~ m/\.\.\/fasta\/(\S+)\.fasta/)
    {
	$id = $1;
	%seqs = ();
	%metaData = ();
	%seqMat = ();
	open FH1,'<',"$ff";
	while(<FH1>)
	{
	    #homo_sapiens.16__1870731__9191__-__90338345
	    if (/>((\S+)\.(\S+)\_\_(\d+)\_\_(\d+)\_\_\S+\_\_\d+)/)
	    {
		$tax = $1;
		$sp = $2;
		$chr = $3;
		$start = $4;
		$len = $5;
		if ($sp eq "homo_sapiens")
		{
		    $metaData{chr} = $chr;
		    $metaData{start} = $start;
		    $metaData{len} = $len;
		}
	    }
	    elsif (/(\S+)/)
	    {
		$seq = $1;
		$seqs{$tax} = $seq;
	    }
	}
	close FH1;

	foreach $tax (sort keys %seqs)
	{
	    @temp = ();
	    @temp = split(//,$seqs{$tax});
	    for $i (0..(scalar(@temp)-1))
	    {
		$seqMat{$tax}[$metaData{start} + $i] = uc($temp[$i]); 
	    }
	}

	foreach $chr (keys %chrList)
	{
	    if ($chr eq "$metaData{chr}")
	    {
		print "Alignment on chromosome $chr\n";
		foreach $i (0..(scalar(@{$cdsCoords{$chr}{start}})-1))
		{
		    if ($cdsCoords{$chr}{start}[$i] >= $metaData{start} && $cdsCoords{$chr}{start}[$i] <= ($metaData{start} + $metaData{len}) && $cdsCoords{$chr}{stop}[$i] >= $metaData{start} && $cdsCoords{$chr}{stop}[$i] <= ($metaData{start} + $metaData{len}))
		    {
			print "EMBEDDED gene region located $cdsCoords{$chr}{start}[$i] $cdsCoords{$chr}{stop}[$i] $metaData{start}\n";
			foreach $tax (sort keys %seqs)
			{
			    for $j (($cdsCoords{$chr}{start}[$i])..($cdsCoords{$chr}{stop}[$i]))
			    {
				$seqMat{$tax}[$j] = "N";
			    }
			}
		    }
		    if ($cdsCoords{$chr}{start}[$i] >= $metaData{start} && $cdsCoords{$chr}{start}[$i] <= ($metaData{start} + $metaData{len}) && $cdsCoords{$chr}{stop}[$i] > $metaData{start} && $cdsCoords{$chr}{stop}[$i] > ($metaData{start} + $metaData{len}))
                    {
                        print "LEFT gene region located $cdsCoords{$chr}{start}[$i] $cdsCoords{$chr}{stop}[$i] $metaData{start}\n";
                    }
		    if ($cdsCoords{$chr}{start}[$i] < $metaData{start} && $cdsCoords{$chr}{start}[$i] < ($metaData{start} + $metaData{len}) && $cdsCoords{$chr}{stop}[$i] >= $metaData{start} && $cdsCoords{$chr}{stop}[$i] <= ($metaData{start} + $metaData{len}))
                    {
                        print "RIGHT gene region located $cdsCoords{$chr}{start}[$i] $cdsCoords{$chr}{stop}[$i] $metaData{start}\n";
                    }
		}
	    }
	}

	open OUT1,'>',"noncoding/$id.mask.all.fasta";
	open OUT2,'>',"noncpg/$id.mask.noncpg.fasta";
	open OUT3,'>',"cpg/$id.mask.cpg.fasta";
	$cpglength = 0;
	foreach $tax (sort keys %seqs)
        {
	    print OUT1 ">$tax\n";
	    print OUT2 ">$tax\n";
	    print OUT3 ">$tax\n";
	    for $j (($metaData{start})..($metaData{start} + $metaData{len}))
	    {
		print OUT1 "$seqMat{$tax}[$j]";
		if (exists $cpgSites{$metaData{chr}}{$j})
		{
		    print OUT3 "$seqMat{$tax}[$j]";
		    $cpglength++;
		}
		elsif (! exists $cpgSites{$metaData{chr}}{$j})
		{
		    print OUT2 "$seqMat{$tax}[$j]";
		}
	    }
	    print OUT1 "\n";
	    print OUT2 "\n";
	    print OUT3 "\n";
	}
	close OUT1;
	close OUT2;
	close OUT3;
	if ($cpglength == 0)
	{
	    unlink("cpg/$id.mask.cpg.fasta");
	}
    }
}
exit;
