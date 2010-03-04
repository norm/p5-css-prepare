package CSS::Prepare::Property::Margin;

use Modern::Perl;



sub parse {
    my %declaration = @_;
    
    my $property = $declaration{'property'};
    my $value    = $declaration{'value'};
    my %canonical;
    
    given ( $property ) {
        when ( 'margin' ) {
            my @values = split( m{\s+}, $value );
            
            given ( $#values ) {
                when ( 0 ) {
                    # top/bottom/left/right shorthand
                    foreach my $subproperty qw( top bottom left right ) {
                        $canonical{"margin-$subproperty"} = $values[0];
                    }
                }
                when ( 1 ) {
                    # top/bottom and left/right shorthand
                    foreach my $subproperty qw ( top bottom ) {
                        $canonical{"margin-$subproperty"} = $values[0];
                    }
                    foreach my $subproperty qw ( left right ) {
                        $canonical{"margin-$subproperty"} = $values[1];
                    }
                }
                when ( 2 ) {
                    # top, left/right and bottom shorthand
                    $canonical{"margin-top"}    = $values[0];
                    $canonical{"margin-bottom"} = $values[2];
                    foreach my $subproperty qw ( left right ) {
                        $canonical{"margin-$subproperty"} = $values[1];
                    }
                }
                when ( 3 ) {
                    # top, right, bottom and left shorthand
                    $canonical{"margin-top"}    = $values[0];
                    $canonical{"margin-bottom"} = $values[2];
                    $canonical{"margin-left"}   = $values[3];
                    $canonical{"margin-right"}  = $values[1];
                }
            }
        }
        when ( 'margin-top' ) {
            $canonical{ $property } = $value;
        }
        when ( 'margin-bottom' ) {
            $canonical{ $property } = $value;
        }
        when ( 'margin-left' ) {
            $canonical{ $property } = $value;
        }
        when ( 'margin-right' ) {
            $canonical{ $property } = $value;
        }
    }
    
    return %canonical;
}

1;
