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

    my $result = 0;
    # determine amounts for each line
    if ( $self->movie->price_code == Movie::REGULAR ) {
        $result += 2;
        $result += ( $self->days_rented - 2 ) * 1.5 if $self->days_rented > 2;
    }
    elsif ( $self->movie->price_code == Movie::NEW_RELEASE ) {
        $result += $self->days_rented * 3;
    }
    elsif ( $self->movie->price_code == Movie::CHILDRENS ) {
        $result += 1.5;
        $result += ( $self->days_rented - 3 ) * 1.5 if $self->days_rented > 3;
    }

    return $result;
}

sub frequent_renter_points
{
    my $self = shift;

    return ( $self->movie->price_code == Movie::NEW_RELEASE && $self->days_rented > 1 ) ? 2 : 1;
}

1;
