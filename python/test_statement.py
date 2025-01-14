from unittest import TestCase

from movie import Movie
from rental import Rental
from customer import Customer

class StatementTests(TestCase):

    def setUp(self):
        movie = Movie("The Watchmen", Movie.NEW_RELEASE)
        movie2 = Movie("The Quiet Man", Movie.REGULAR)
        movie3 = Movie("Ice Age", Movie.CHILDRENS)

        rental = Rental(movie, 42)
        self.customer = Customer('alexm')
        self.customer.add_rental(rental)
        rental2 = Rental(movie2, 7)
        self.customer.add_rental(rental2)
        rental3 = Rental(movie3, 2)
        self.customer.add_rental(rental3)

    def test_statement(self):
        statement_exp = """Rental Record for alexm
\tThe Watchmen\t126
\tThe Quiet Man\t9.5
\tIce Age\t1.5
Amount owed is 137.0
You earned 4 frequent renter points"""
        self.assertEqual(statement_exp, self.customer.statement())

    def test_html_statement(self):
        html_statement_exp = """<h1>Rental Record for <em>alexm</em></h1><p>
\tThe Watchmen: 126<br>
\tThe Quiet Man: 9.5<br>
\tIce Age: 1.5<br>
<p>You owe <em>137.0</em></p>
On this rental you earned <em>4</em> frequent renter points</p>"""
        self.assertEqual(html_statement_exp, self.customer.html_statement())
