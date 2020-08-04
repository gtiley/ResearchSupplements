#!/usr/bin/perl -w
#samp.0.0.log
for $i (0..0)
{
    for $j (0..1)
    {
	$input = "$i.$j/samp.multicntrl.dat";
	open FH1,'<',"$input";
	open OUT1,'>',"$i.$j/samp.$i.$j.log";
print OUT1 "Sample\tt0\tt1\tt2\tt3\tt4\tt5\tt6\tt7\tt8\tt9\tt10\tr00\tr01\tr02\tr03\tr04\tr05\tr06\tr07\tr08\tr09\tr010\tv0\tr10\tr11\tr12\tr13\tr14\tr15\tr16\tr17\tr18\tr19\tr110\tv1\tr20\tr21\tr22\tr23\tr24\tr25\tr26\tr27\tr28\tr29\tr210\tv2\tr30\tr31\tr32\tr33\tr34\tr35\tr36\tr37\tr38\tr39\tr310\tv3\tr40\tr41\tr42\tr43\tr44\tr45\tr46\tr47\tr48\tr49\tr410\tv4\tr50\tr51\tr52\tr53\tr54\tr55\tr56\tr57\tr58\tr59\tr510\tv5\tr60\tr61\tr62\tr63\tr64\tr65\tr66\tr67\tr68\tr69\tr610\tv6\tr70\tr71\tr72\tr73\tr74\tr75\tr76\tr77\tr78\tr79\tr710\tv7\tr80\tr81\tr82\tr83\tr84\tr85\tr86\tr87\tr88\tr89\tr810\tv8\n";
$ngen = 0;
while(<FH1>)
{
    $line = $_;
    chomp $line;
    @temp = ();
    @temp = split(/\s+/,$line);
    for $i (1..(scalar(@temp)-1))
    {
#	print "$i\t$temp[$i]\n";
	if ($i == 1)
	{
	    print OUT1 "$ngen\t$temp[$i]"; 
	}
	elsif ($i > 1)
	{
	    print OUT1 "\t$temp[$i]";
	}
    }
    print OUT1 "\n";
    $ngen = $ngen + 10000;
}
close OUT1;
close FH1;
    }
}
exit;
