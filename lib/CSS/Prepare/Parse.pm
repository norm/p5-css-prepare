package CSS::Prepare::Parse;

use Modern::Perl;



sub parse {
    my $string = shift;
    
    my $stripped     = strip_comments( $string );
    my @media_blocks = split_into_media_blocks( $stripped );
    my @declarations;
    
    foreach my $media_block ( @media_blocks ) {
        my @declaration_blocks 
            = split_into_declaration_blocks( $media_block );
        
        foreach my $block ( @declaration_blocks ) {
            use Data::Dumper::Concise;
            print Dumper $block;
            
            # replace the string with a data
            # structure of selectors
            $block->{'selector'} = parse_selectors( $block->{'selector'} );
            
            # replace the string with a data structure of
            # declarations and their properties
            $block->{'block'} 
                = parse_declaration_block( $block->{'block'} );
            
            push @declarations, $block;
        }
    }
    
    return @declarations;
}

sub strip_comments {
    my $string = shift;
    
    return $string;
}

sub split_into_media_blocks {
    my $string = shift;
    my @blocks;
    
    push @blocks, $string;
    
    return @blocks;
}

sub split_into_declaration_blocks {
    my $string = shift;
    my @blocks;
    
    my $splitter = qr{
            ^
            \s*
            (?<selector> .*? )
            \s*
            \{
                (?<block> [^\}]+ )
            \}
        }sx;
    
    while ( $string =~ s{$splitter}{}sx ) {
        my %match = %+;
        push @blocks, \%match;
    }
    
    return @blocks;
}

sub parse_selectors {
    my $string = shift;
    my @selectors;
    
    my $splitter = qr{
            ^
            \s*
            ( [^,]+ )
            \s*
            \,?
        }sx;
    
    while ( $string =~ s{$splitter}{}sx ) {
        push @selectors, $1;
    }
    
    return \@selectors;
}

sub parse_declaration_block {
    my $string = shift;
    my @declarations;
    
    my $splitter = qr{
            ^
            \s*
            (?<property> [^:]+ )
            \:
            \s*
            (?<value> [^;]+ )
            \;?
        }sx;
    
    while ( $string =~ s{$splitter}{}sx ) {
        my %match = %+;
        push @declarations, \%match;
    }
    
    return \@declarations;
}

1;
