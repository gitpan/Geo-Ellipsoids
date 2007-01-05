#!/usr/bin/perl -w

=head1 NAME

example-list.pl - Geo::Ellipsoids list method example

=cut

use strict;
use lib qw{./lib ../lib};
use Geo::Ellipsoids;

my $obj=Geo::Ellipsoids->new(); #defaults to WGS84
my $list=$obj->list;
foreach (sort @$list) {
  $obj->set($_);
  print "Short Name: ", $obj->shortname, "\n";
  print "Long Name:  ", $obj->longname, "\n";
  print "Ellipsoid:  ", "{a=>",$obj->a,",b=>",$obj->b,"}", "\n";
  print "\n";
}
foreach (100,110,120,130) {
  $obj->set({a=>1,i=>$_});
  print "Short Name: ", $obj->shortname, "\n";
  print "Long Name:  ", $obj->longname, "\n";
  print "Ellipsoid:  ", "{a=>",$obj->a,",b=>",$obj->b,"}", "\n";
  print "\n";
}
