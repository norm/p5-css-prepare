use strict;
use warnings;

use Test::More qw( no_plan );

use CSS::Prepare;

my $cp = CSS::Prepare->new();


# check that multiple matching padding values are correctly 
# turned into a two-value shorthand
my $input = <<CSS;
    div {
        padding: 0;
    }
    div {
        padding-top: 1em;
        padding-bottom: 1em;
    }
CSS
my $output = <<CSS;
div{padding:1em 0;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $output, 'padding two-value shorthand' );


# check that multiple matching padding values are correctly 
# turned into a three-value shorthand
my $input = <<CSS;
    div {
        padding: 0;
        padding-bottom: 5px;
    }
    div {
        padding-left: 1em;
        padding-right: 1em;
    }
CSS
my $output = <<CSS;
div{padding:0 1em 5px;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $output, 'padding three-value shorthand' );
