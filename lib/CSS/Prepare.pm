package CSS::Prepare;

use strict;
use warnings;

use Exporter;


# boilerplate new function
sub new {
    my $proto = shift;
    my $args  = shift;
    
    my $class = ref $proto || $proto;
    my $self  = {};
    bless $self, $class;
    
    return $self;
}

1;
