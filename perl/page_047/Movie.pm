use strict;
use warnings;

package Movie;

use Moo;

use constant REGULAR     => 0;
use constant NEW_RELEASE => 1;
use constant CHILDRENS   => 2;

has title => (
    is => 'ro',
);

has price_code => (
    is      => 'rw',
    trigger => 1,
);

has price => (
    is   => 'rwp',
    lazy => 1,
);

sub _trigger_price_code
{
    my $self = shift;
    my ($value) = @_;

    if ( $value == REGULAR ) {
        $self->_set_price( RegularPrice->new() );
    }
    elsif ( $value == NEW_RELEASE ) {
        $self->_set_price( NewReleasePrice->new() );
    }
    elsif ( $value == CHILDRENS ) {
        $self->_set_price( ChildrensPrice->new() );
    }
}

sub charge
{
    my $self = shift;
    my ($days_rented) = @_;

    return $self->price->charge($days_rented);
}

sub frequent_renter_points
{
    my $self = shift;
    my ($days_rented) = @_;

    return $self->price->frequent_renter_points($days_rented);
}

package DefaultPrice;

sub frequent_renter_points
{
    return 1;
}

package RegularPrice;

use Moo;
extends 'DefaultPrice';

sub charge
{
    my $self = shift;
    my ($days_rented) = @_;

    my $result = 2;
    $result += ( $days_rented - 2 ) * 1.5 if $days_rented > 2;

    return $result;
}

package NewReleasePrice;

use Moo;

sub charge
{
    my $self = shift;
    my ($days_rented) = @_;

    return $days_rented * 3;
}

sub frequent_renter_points
{
    my $self = shift;
    my ($days_rented) = @_;

    return $days_rented > 1 ? 2 : 1;
}

package ChildrensPrice;

use Moo;
extends 'DefaultPrice';

sub charge
{
    my $self = shift;
    my ($days_rented) = @_;

    my $result = 1.5;
    $result += ( $days_rented - 3 ) * 1.5 if $days_rented > 3;

    return $result;
}

1;
