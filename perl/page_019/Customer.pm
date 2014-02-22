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

    my ( $total_amount, $frequent_renter_points ) = ( 0, 0 );
    my $result = "Rental Record for " . $self->name . "\n";
    for my $element (@{ $self->rentals }) {
        $frequent_renter_points = $element->frequent_renter_points();

        # show figures for this rental
        $result .= "\t" . $element->movie->title . "\t" . $element->charge() . "\n";
        $total_amount += $element->charge();
    }
    # add footer lines
    $result .= "Amount owed is $total_amount\n";
    $result .= "You earned $frequent_renter_points frequent renter points";
    return $result;
}

1;
