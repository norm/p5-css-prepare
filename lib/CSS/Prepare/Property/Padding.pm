package CSS::Prepare::Property::Padding;

use Modern::Perl;



sub parse {
    my %declaration = @_;
    
    my $property = $declaration{'property'};
    my $value    = $declaration{'value'};
    my %canonical;
    
    given ( $property ) {
        when ( 'padding' ) {
            my @values = split( m{\s+}, $value );
            
            given ( $#values ) {
                when ( 0 ) {
                    # top/bottom/left/right shorthand
                    foreach my $subproperty qw( top bottom left right ) {
                        $canonical{"padding-$subproperty"} = $values[0];
                    }
                }
                when ( 1 ) {
                    # top/bottom and left/right shorthand
                    foreach my $subproperty qw ( top bottom ) {
                        $canonical{"padding-$subproperty"} = $values[0];
                    }
                    foreach my $subproperty qw ( left right ) {
                        $canonical{"padding-$subproperty"} = $values[1];
                    }
                }
                when ( 2 ) {
                    # top, left/right and bottom shorthand
                    $canonical{"padding-top"}    = $values[0];
                    $canonical{"padding-bottom"} = $values[2];
                    foreach my $subproperty qw ( left right ) {
                        $canonical{"padding-$subproperty"} = $values[1];
                    }
                }
                when ( 3 ) {
                    # top, right, bottom and left shorthand
                    $canonical{"padding-top"}    = $values[0];
                    $canonical{"padding-bottom"} = $values[2];
                    $canonical{"padding-left"}   = $values[3];
                    $canonical{"padding-right"}  = $values[1];
                }
            }
        }
        when ( 'padding-top' ) {
            $canonical{ $property } = $value;
        }
        when ( 'padding-bottom' ) {
            $canonical{ $property } = $value;
        }
        when ( 'padding-left' ) {
            $canonical{ $property } = $value;
        }
        when ( 'padding-right' ) {
            $canonical{ $property } = $value;
        }
    }
    
    return %canonical;
}

1;
