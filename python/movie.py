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

    def charge(self, days_rented):
        result = 0
        match self.price_code:
            case Movie.REGULAR:
                result += 2
                if days_rented > 2: result += (days_rented - 2) * 1.5
            case Movie.NEW_RELEASE:
                result += days_rented * 3
            case Movie.CHILDRENS:
                result += 1.5
                if days_rented > 3: result += (days_rented - 3) * 1.5
        return result

    def frequent_renter_points(self, days_rented):
        return 2 if self.price_code == Movie.NEW_RELEASE and days_rented > 1 else 1
