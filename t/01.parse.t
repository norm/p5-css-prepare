use Modern::Perl;
use Test::More  tests => 2;

use CSS::Prepare;
use Data::Dumper;


my $preparer = CSS::Prepare->new();
my( $css, @structure, @parsed );


# basic stylesheet
{
    $css = <<CSS;
        h1 { color: red; }
CSS
    @structure = (
            {
                selector => [ 'h1' ],
                block => [
                    {
                        property => 'color',
                        value    => 'red',
                    },
                ],
            },
        );

    @parsed = $preparer->parse_string( $css );
    is_deeply( \@structure, \@parsed )
        or say "basic stylesheet was:\n" . Dumper \@parsed;
}

# stylesheet with more than one declaration block
{
    $css = <<CSS;
        h1 { color: red; }
        #header { background: #fed; }
        p, li { margin-top: 5px; margin-bottom: 5px; }
CSS
    @structure = (
            {
                selector => [ 'h1' ],
                block => [
                    {
                        property => 'color',
                        value    => 'red',
                    },
                ],
            },
            {
                selector => [ '#header' ],
                block => [
                    {
                        property => 'background',
                        value    => '#fed',
                    },
                ],
            },
            {
                selector => [ 'p', 'li' ],
                block => [
                    {
                        property => 'margin-top',
                        value    => '5px',
                    },
                    {
                        property => 'margin-bottom',
                        value    => '5px',
                    },
                    ],
            },
        );

    @parsed = $preparer->parse_string( $css );
    is_deeply( \@structure, \@parsed )
        or say "basic stylesheet was:\n" . Dumper \@parsed;
}

# TODO 
#   -   stylesheet with invalid syntax 
#   -   stylesheet with an @media block 
#   -   stylesheet with broken @media block
