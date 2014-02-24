#!/usr/bin/env ruby

require 'test/unit'
require 'movie'
require 'rental'
require 'customer'

class StatementTest < Test::Unit::TestCase
    def setup
        if Movie.instance_methods.find_index(:price=)
            movie = Movie.new("The Watchmen", NewReleasePrice.new)
            movie2 = Movie.new("The Quiet Man", RegularPrice.new)
            movie3 = Movie.new("Ice Age", ChildrensPrice.new)
        else
            movie = Movie.new("The Watchmen", Movie::NEW_RELEASE)
            movie2 = Movie.new("The Quiet Man", Movie::REGULAR)
            movie3 = Movie.new("Ice Age", Movie::CHILDRENS)
        end
        rental = Rental.new(movie, 42)
        @customer = Customer.new('alexm')
        @customer.add_rental(rental)
        rental2 = Rental.new(movie2, 7)
        @customer.add_rental(rental2)
        rental3 = Rental.new(movie3, 2)
        @customer.add_rental(rental3)
    end
    def test_statement
        statement_exp = <<EoS.chomp
Rental Record for alexm
\tThe Watchmen\t126
\tThe Quiet Man\t9.5
\tIce Age\t1.5
Amount owed is 137.0
You earned 4 frequent renter points
EoS
        assert_equal statement_exp, @customer.statement
    end
    def test_html_statement
        html_statement_exp = <<EoS.chomp
<h1>Rentals for <em>alexm</em></h1><p>
\tThe Watchmen: 126<br>
\tThe Quiet Man: 9.5<br>
\tIce Age: 1.5<br>
<p>You owe <em>137.0</em><p>
On this rental you earned <em>4</em> frequent renter points<p>
EoS
        assert_equal html_statement_exp, @customer.html_statement if @customer.respond_to?(:html_statement)
    end
end
