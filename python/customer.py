from movie import Movie


class Customer:
    def __init__(self, name):
        self._name = name
        self._rentals = []

    @property
    def name(self):
        return self._name

    def add_rental(self, arg):
        self._rentals.append(arg)

    def statement(self):
        total_amount = 0
        frequent_renter_points = 0
        result = f"Rental Record for {self.name}\n"
        for element in self._rentals:
            # show figures for this rental
            result += "\t" + element.movie.title + "\t" + str(element.charge) + "\n"

        # add footer lines
        result += f"Amount owed is {self._total_charge}\n"
        result += f"You earned {self._total_frequent_renter_points} frequent renter points"
        return result

    @property
    def _total_charge(self):
        result = sum(rental.charge for rental in self._rentals)
        return result

    @property
    def _total_frequent_renter_points(self):
        return sum(rental.frequent_renter_points for rental in self._rentals)

    def html_statement(self):
        result = f"<h1>Rental Record for <em>{self.name}</em></h1><p>\n"
        for element in self._rentals:
            # show figures for this rental
            result += "\t" + f"{element.movie.title}: {element.charge}<br>\n"

        # add footer lines
        result += f"<p>You owe <em>{self._total_charge}</em></p>\n"
        result += f"On this rental you earned <em>{self._total_frequent_renter_points}</em> frequent renter points</p>"
        return result
