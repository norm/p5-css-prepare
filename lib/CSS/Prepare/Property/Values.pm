package CSS::Prepare::Property::Border;

use Modern::Perl;
use Exporter;

our @ISA    = qw( Exporter );
our @EXPORT = qw( is_style_value );



sub is_style_value {
    my $value  = shift;
    
    my @styles = qw( 
            none    hidden  dotted  dashed  solid 
            double  groove  ridge   inset   outset 
        );
    
    foreach my $style ( @styles ) {
        return 1
            if $style eq $value;
    }
    
    return 0;
}

sub is_colour_value {
    my $value = shift;
    
    # is RGB in hex
    return 1
        if $value =~ m{^ \# [0-9a-fA-F]{3} }x;
    return 1
        if $value =~ m{^ \# [0-9a-fA-F]{6} }x;
    
    # is RGB in functional
    return 1
        if $value =~ m{^ rgb \( }x;
    
    my @colours = qw( 
            aqua    black   blue    fuchsia gray    green
            lime    maroon  navy    olive   orange  purple
            red     silver  teal    white   yellow
        );
    
    # is colour keyword
    foreach my $colour ( @colours ) {
        return 1
            if $colour eq $value;
    }
    
    return 0;
}