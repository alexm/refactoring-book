#!/usr/bin/env ruby

require 'test/unit'
require 'movie'
require 'rental'
require 'customer'

class StatementTest < Test::Unit::TestCase
    def setup
        movie = Movie.new("The Watchmen", Movie::NEW_RELEASE)
        rental = Rental.new(movie, 42)
        @customer = Customer.new('alexm')
        @customer.add_rental(rental)
    end
    def test_statement
        statement_exp = <<EoS.chomp
Rental Record for alexm
\tThe Watchmen\t126
Amount owed is 126
You earned 2 frequent renter points
EoS
        assert_equal statement_exp, @customer.statement
    end
    def test_html_statement
        html_statement_exp = <<EoS.chomp
<h1>Rentals for <em>alexm</em></h1><p>
\tThe Watchmen: 126<br>
<p>You owe <em>126</em><p>
On this rental you earned <em>2</em> frequent renter points<p>
EoS
        assert_equal html_statement_exp, @customer.html_statement if @customer.respond_to?(:html_statement)
    end
end
