class Movie:
    REGULAR = 0
    NEW_RELEASE = 1
    CHILDRENS = 2

    def __init__(self, title, price_code):
        self._title = title
        self.price_code = price_code

    @property
    def title(self):
        return self._title

    @property
    def price_code(self):
        return self._price_code

    @price_code.setter
    def price_code(self, value):
        self._price_code = value
        match value:
            case Movie.REGULAR:
                self._price = RegularPrice()
            case Movie.NEW_RELEASE:
                self._price = NewReleasePrice()
            case Movie.CHILDRENS:
                self._price = ChildrensPrice()

    def charge(self, days_rented):
        return self._price.charge(days_rented)

    def frequent_renter_points(self, days_rented):
        return self._price.frequent_renter_points(days_rented)


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
