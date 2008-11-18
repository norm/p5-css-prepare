use strict;
use warnings;

use Test::More tests => 3;

# ensure the module can be loaded, returns the right object and that it is
# also a subclass of LWP::UserAgent module (and so can fetch URLs)

use_ok( 'CSS::Prepare' );

my $upcoming = CSS::Prepare->new();
isa_ok( $upcoming, 'CSS::Prepare' );
