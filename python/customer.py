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
            frequent_renter_points += element.frequent_renter_points

            # show figures for this rental
            result += "\t" + element.movie.title + "\t" + str(element.charge) + "\n"
            total_amount += element.charge

        # add footer lines
        result += f"Amount owed is {total_amount}\n"
        result += f"You earned {frequent_renter_points} frequent renter points"
        return result
