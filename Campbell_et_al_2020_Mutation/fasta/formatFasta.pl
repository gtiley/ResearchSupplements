#!/usr/bin/perl -w

@mafFiles = glob("../46_mammals.epo/*.maf");
foreach $mf (@mafFiles)
{
    open FH1,'<',"$mf";
    while(<FH1>)
    {
	# id: 17510000754540
	if (/^#\s+id:\s+(\d+)/)
	{
	    $id = $1;
	    %seqs = ();
	    $ntax = 0;
	}
	if (/^s\s+(homo_sapiens\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(pongo_abelii\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(pan_troglodytes\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(mus_musculus\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(callithrix_jacchus\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(chlorocebus_sabaeus\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	if (/^s\s+(microcebus_murinus\.\S+\s+\d+\s+\d+\s+\S+\s+\d+)\s+(\S+)/)
	{
	    $header = $1;
	    $seq = $2;
	    $header =~ s/\s+/__/g;
	    $seqs{$header} = $seq;
	    $ntax++;
	}
	
	if ($ntax == 7)
	{
	    open OUT1,'>',"$id.fasta";
	    foreach $header (sort keys %seqs)
	    {
		print OUT1 ">$header\n$seqs{$header}\n";
	    }
	    close OUT1;
	}
    }
    close FH1;
}
exit;
