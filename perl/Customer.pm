package Customer;

use strict;
use warnings;

use Moo;
use Movie;

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

    push $self->rentals, $arg;
}

sub statement
{
    my $self = shift;

    my $frequent_renter_points = 0;
    my $result = "Rental Record for " . $self->name . "\n";
    for my $element (@{ $self->rentals }) {
        $frequent_renter_points += $element->frequent_renter_points();

        # show figures for this rental
        $result .= "\t" . $element->movie->title . "\t" . $element->charge() . "\n";
    }
    # add footer lines
    $result .= "Amount owed is " . $self->_total_charge() . "\n";
    $result .= "You earned $frequent_renter_points frequent renter points";
    return $result;
}

sub _total_charge
{
    my $self = shift;

    my $result = 0;
    for my $element (@{ $self->rentals }) {
        $result += $element->charge();
    }

    return $result;
}

1;
