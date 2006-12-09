#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: base.t,v 0.1 2006/02/21 eserte Exp $
# Author: Michael R. Davis
#

=head1 Test Examples

base.t has good examples concerning how to use this module

=cut

use strict;
use lib q{lib};
use lib q{../lib};
use constant NEAR_DEFAULT => 7;

sub near {
  my $x=shift();
  my $y=shift();
  my $p=shift()||NEAR_DEFAULT;
  if (($x-$y)/$y < 10**-$p) {
    return 1;
  } else {
    return 0;
  }
}

BEGIN {
    if (!eval q{
	use Test;
	1;
    }) {
	print "1..0 # tests only works with installed Test module\n";
	exit;
    }
}

BEGIN { plan tests => 37 }

# just check that all modules can be compiled
ok(eval {require Geo::Ellipsoids; 1}, 1, $@);

my $o = Geo::Ellipsoids->new();
ok(ref $o, "Geo::Ellipsoids");

my $obj=Geo::Ellipsoids->new();
$obj->set({a=>1,b=>1}); # a 1 unit sphere
ok($obj->a, 1);
ok($obj->b, 1);
ok($obj->i, undef);
ok($obj->f, 0);

$obj->set({a=>1,b=>0.995});
ok($obj->a, 1);
ok($obj->b, 0.995);
ok($obj->i, 200);
ok($obj->f, 0.005);

$obj->set({a=>1,i=>200});
ok($obj->a, 1);
ok($obj->b, 0.995);
ok($obj->i, 200);
ok($obj->f, 0.005);

$obj->set({a=>1,f=>0.005});
ok($obj->a, 1);
ok($obj->b, 0.995);
ok($obj->i, 200);
ok($obj->f, 0.005);

$obj->set({a=>1});
ok($obj->a, 1);
ok($obj->b, 1);
ok($obj->i, undef());
ok($obj->f, 0);
ok($obj->e, 0);
ok near($obj->equatorial_circumference, 8 * atan2(1,1), 13);
ok near($obj->polar_circumference, 8 * atan2(1,1), 13);

$obj->set('WGS84');
ok($obj->a, 6378137);
ok near($obj->b, 6356752.31424518, 13);
ok($obj->i, 298.257223563);
ok near($obj->f, 0.00335281066474748, 12);

#For the Clarke 1866, e² is 0.006768658.
$obj->set('Clarke 1866');
ok near($obj->e2, 0.006768658, 7);

#For the GRS 80, e² is 0.0066943800.
$obj->set('GRS80');
ok near($obj->e2, 0.0066943800, 6);

$obj->set('WGS84');
ok($obj->shortname, "WGS84");
ok($obj->longname, "World Geodetic System of 1984");

ok near($obj->equatorial_circumference, 40075016.6855785, 13);
ok near($obj->polar_circumference, 39940652.7422451, 13);

#Just testing that n works. It is not my formula.
ok(near $obj->n(39.56789), 6386817.167912991, 13);
ok(near $obj->n_rad(0.690589958566939), 6386817.167912991, 13);
