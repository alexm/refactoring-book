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

1;
