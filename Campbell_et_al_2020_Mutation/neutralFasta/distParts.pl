#!/usr/bin/perl -w

for $i (0..9)
{
    for $j (0..9)
    {
	$id = "";
	$id = "$j" . "$i";
	system "perl maskFasta.subType.3.pl $id";
    }
}
exit;
