#!/usr/bin/env ruby

require 'movie'
require 'rental'
require 'customer'

movie = Movie.new("The Watchmen", Movie::NEW_RELEASE)
rental = Rental.new(movie, 42)
customer = Customer.new('alexm')
customer.add_rental(rental)
puts customer.statement
