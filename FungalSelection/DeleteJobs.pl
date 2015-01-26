#!/usr/bin/perl

for(2459550..2459848)
{
    $num = $_;
#    print "$num\n";
   system "qdel $num";
}
exit;
