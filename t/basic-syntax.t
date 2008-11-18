use strict;
use warnings;

use Test::More qw( no_plan );

use CSS::Prepare;

my $cp = CSS::Prepare->new();

# whitespace should be removed
my $input = <<CSS;
    div {
        margin: 10px;
    }
CSS
my $output = <<CSS;
div{margin:10px;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();

ok( $test eq $output, 'whitespace removal' );


# zero units equals zero
$input = <<CSS;
    div {
        margin: 0px;
    }
CSS
$output = <<CSS;
div{margin:0;}
CSS

$cp->from_string( $input );
$test = $cp->to_string();

ok( $test eq $output, 'zero has no units' );


# last rule wins in the cascade
$input = <<CSS;
    div {
        margin: 0;
    }
    div {
        margin: 3px;
    }
CSS
$output = <<CSS;
div{margin:3px;}
CSS

$cp->from_string( $test );
$test = $cp->to_string();

ok( $test eq $output, 'last-rule-wins cascade' );
