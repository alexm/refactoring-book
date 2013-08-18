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
        my $this_amount = 0;
        # determine amounts for each line
        if ( $element->movie->price_code == Movie::REGULAR ) {
            $this_amount += 2;
            $this_amount += ( $element->days_rented - 2 ) * 1.5 if $element->days_rented > 2;
        }
        elsif ( $element->movie->price_code == Movie::NEW_RELEASE ) {
            $this_amount += $element->days_rented * 3;
        }
        elsif ( $element->movie->price_code == Movie::CHILDRENS ) {
            $this_amount += 1.5;
            $this_amount += ( $element->days_rented - 3 ) * 1.5 if $element->days_rented > 3;
        }
        # add frequent renter points
        $frequent_renter_points += 1;
        # add bonus for a two day new release rental
        if ( $element->movie->price_code == Movie::NEW_RELEASE && $element->days_rented > 1 ) {
            $frequent_renter_points += 1;
        }
        # show figures for this rental
        $result .= "\t" . $element->movie->title . "\t" . $this_amount . "\n";
        $total_amount += $this_amount;
    }
    # add footer lines
    $result .= "Amount owed is $total_amount\n";
    $result .= "You earned $frequent_renter_points frequent renter points";
    return $result;
}

1;
