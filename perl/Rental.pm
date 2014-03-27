package Rental;

use strict;
use warnings;

use Moo;

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

    return $self->movie->frequent_renter_points( $self->days_rented );
}

1;
