use strict;
use warnings;

use Test::More qw( no_plan );

use CSS::Prepare;

my $cp = CSS::Prepare->new();


# check individual border properties are output in shorthand form
my $input = <<CSS;
    div {
        border-color: black;
        border-width: 1px;
        border-style: solid;
    }
CSS
my $output = <<CSS;
div{border:1px solid black;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $output, 'border shorthand' );
