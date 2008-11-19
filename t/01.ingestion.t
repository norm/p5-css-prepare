use strict;
use warnings;

use Test::More qw( no_plan );

use CSS::Prepare;

my $document_root = 't/docroot';


my $cp = CSS::Prepare->new(
    'document_root' => ${document_root},
    'preserve'      => 1,   # over-ride all rewriting options, so as to 
                            # test just the ingestion methods
);


# test simple text string input
my $input = <<CSS;
    /* a 
     * multiline 
     * comment 
     */

    a {
        text-decoration: underline;
        color: #000;
        background: inherit;
    }
    
    div {
        margin: 0;
    }
    
CSS

$cp->from_string( $input );
my $test = $cp->to_string();
ok( $test eq $input, 'string input' );


# test @import finds a relative file (CSS spec states: "For CSS style sheets,
# the base URI is that of the style sheet, not that of the source document")
$input = <<CSS;

    @import url( ${document_root}/relative.css );

CSS
my $output = <<CSS;

div {
    padding: 0;
    margin: 0;
}

CSS

$cp->from_string( $input );
$test = $cp->to_string();
ok( $test eq $input, 'relative path @import' );


# test @import finds a file with an "absolute" path
$input = <<CSS;

    @import url( /css/absolute.css );

CSS
$output = <<CSS;

a {
    text-decoration: underline;
    color: #000;
    background: inherit;
}

CSS

$cp->from_string( $input );
$test = $cp->to_string();
ok( $test eq $output, 'absolute path @import' );
