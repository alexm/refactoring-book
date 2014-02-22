package Rental;

use strict;
use warnings;

use Moo;
use Movie;

has movie => (
    is => 'ro',
);

has days_rented => (
    is => 'ro',
);

sub charge
{
    my $self = shift;

    return $self->movie->charge( $self->days_rented );
}

sub frequent_renter_points
{
    my $self = shift;

    return ( $self->movie->price_code == Movie::NEW_RELEASE && $self->days_rented > 1 ) ? 2 : 1;
}

1;
