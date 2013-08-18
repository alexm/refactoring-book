#!perl

use strict;
use warnings;

use Test::More;

use Movie;
use Rental;
use Customer;

chomp(
    my $statement_exp = <<EoS
Rental Record for alexm
\tThe Watchmen\t126
Amount owed is 126
You earned 2 frequent renter points
EoS
);

my $movie    = Movie->new( title => "The Watchmen", price_code => Movie::NEW_RELEASE );
my $rental   = Rental->new( movie => $movie, days_rented => 42 );
my $customer = Customer->new( name => 'alexm' );

$customer->add_rental($rental);
is( $statement_exp, $customer->statement );

done_testing();
