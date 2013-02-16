#!/usr/bin/env ruby

require 'test/unit'
require 'movie'
require 'rental'
require 'customer'

class StatementTest < Test::Unit::TestCase
	def test_statement
                statement_exp = <<EoS.chomp
Rental Record for alexm
\tThe Watchmen\t126
Amount owed is 126
You earned 2 frequent renter points
EoS
		movie = Movie.new("The Watchmen", Movie::NEW_RELEASE)
		rental = Rental.new(movie, 42)
		customer = Customer.new('alexm')
		customer.add_rental(rental)
		assert_equal statement_exp, customer.statement
	end
end
