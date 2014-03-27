package Movie;

use strict;
use warnings;

use Moo;

use constant REGULAR     => 0;
use constant NEW_RELEASE => 1;
use constant CHILDRENS   => 2;

has title => (
    is => 'ro',
);

has price_code => (
    is      => 'rw',
    builder => 1,
);

sub _build_price_code {
    my $self = shift;
    my ($value) = @_;

    return $value;
}

sub charge
{
    my $self = shift;
    my ($days_rented) = @_;

    my $result = 0;
    # determine amounts for each line
    if ( $self->price_code == REGULAR ) {
        $result += 2;
        $result += ( $days_rented - 2 ) * 1.5 if $days_rented > 2;
    }
    elsif ( $self->price_code == NEW_RELEASE ) {
        $result += $days_rented * 3;
    }
    elsif ( $self->price_code == CHILDRENS ) {
        $result += 1.5;
        $result += ( $days_rented - 3 ) * 1.5 if $days_rented > 3;
    }

    return $result;
}

sub frequent_renter_points
{
    my $self = shift;
    my ($days_rented) = @_;

    return ( $self->price_code == NEW_RELEASE && $days_rented > 1 ) ? 2 : 1;
}

package RegularPrice;

package NewReleasePrice;

package ChildrensPrice;

1;
