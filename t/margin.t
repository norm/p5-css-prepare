use strict;
use warnings;

use Test::More qw( no_plan );

use CSS::Prepare;

my $cp = CSS::Prepare->new();


# check that multiple matching margin values are correctly 
# turned into a two-value shorthand
my $input = <<CSS;
    div {
        margin: 0;
    }
    div {
        margin-top: 1em;
        margin-bottom: 1em;
    }
CSS
my $output = <<CSS;
div{margin:1em 0;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $output, 'margin two-value shorthand' );


# check that multiple matching margin values are correctly 
# turned into a three-value shorthand
my $input = <<CSS;
    div {
        margin: 0;
        margin-bottom: 5px;
    }
    div {
        margin-left: 1em;
        margin-right: 1em;
    }
CSS
my $output = <<CSS;
div{margin:0 1em 5px;}
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $output, 'margin three-value shorthand' );
