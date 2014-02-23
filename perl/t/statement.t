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
\tThe Quiet Man\t9.5
\tIce Age\t1.5
Amount owed is 137
You earned 4 frequent renter points
EoS
);

chomp(
    my $html_statement_exp = <<EoS
<h1>Rentals for <em>alexm</em></h1><p>
\tThe Watchmen: 126<br>
\tThe Quiet Man: 9.5<br>
\tIce Age: 1.5<br>
<p>You owe <em>137</em><p>
On this rental you earned <em>4</em> frequent renter points<p>
EoS
);

my $movie    = Movie->new( title => "The Watchmen", price_code => Movie::NEW_RELEASE );
my $rental   = Rental->new( movie => $movie, days_rented => 42 );
my $customer = Customer->new( name => 'alexm' );
$customer->add_rental($rental);

my $movie2  = Movie->new( title => "The Quiet Man", price_code => Movie::REGULAR );
my $rental2 = Rental->new( movie => $movie2, days_rented => 7 );
$customer->add_rental($rental2);

my $movie3  = Movie->new( title => "Ice Age", price_code => Movie::CHILDRENS );
my $rental3 = Rental->new( movie => $movie3, days_rented => 2 );
$customer->add_rental($rental3);

is( $customer->statement, $statement_exp );

is( $customer->html_statement, $html_statement_exp ) if $customer->can('html_statement');

done_testing();
