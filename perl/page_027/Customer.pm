package Customer;

use strict;
use warnings;

use Moo;
use Movie;
use List::Util qw< sum >;

has name => (
    is => 'ro',
);

has rentals => (
    is      => 'ro',
    default => sub{ [] },
);

sub add_rental
{
    my $self  = shift;
    my ($arg) = @_;

    push @{ $self->rentals }, $arg;
}

sub statement
{
    my $self = shift;

    my $result = "Rental Record for " . $self->name . "\n";
    for my $element (@{ $self->rentals }) {
        # show figures for this rental
        $result .= "\t" . $element->movie->title . "\t" . $element->charge() . "\n";
    }
    # add footer lines
    $result .= "Amount owed is " . $self->total_charge() . "\n";
    $result .= "You earned " . $self->total_frequent_renter_points() . " frequent renter points";
    return $result;
}

sub total_charge
{
    my $self = shift;

    return sum(map { $_->charge() } @{ $self->rentals });
}

sub total_frequent_renter_points
{
    my $self = shift;

    return sum(map { $_->frequent_renter_points() } @{ $self->rentals });
}

1;
