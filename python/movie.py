class Movie:
    def __init__(self, title, price):
        self._title = title
        self.price = price

    @property
    def title(self):
        return self._title

    def charge(self, days_rented):
        return self.price.charge(days_rented)

    def frequent_renter_points(self, days_rented):
        return self.price.frequent_renter_points(days_rented)


class DefaultPrice:
    @staticmethod
    def frequent_renter_points(days_rented):
        return 1

class RegularPrice(DefaultPrice):
    @staticmethod
    def charge(days_rented):
        result = 2
        if days_rented > 2:
            result += (days_rented - 2) * 1.5
        return result

class NewReleasePrice:
    @staticmethod
    def charge(days_rented):
        return days_rented * 3

    @staticmethod
    def frequent_renter_points(days_rented):
        return 2 if days_rented > 1 else 1

class ChildrensPrice(DefaultPrice):
    @staticmethod
    def charge(days_rented):
        result = 1.5
        if days_rented > 3:
            result += (days_rented - 3) * 1.5
        return result
