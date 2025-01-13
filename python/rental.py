from movie import Movie


class Rental:
    def __init__(self, movie, days_rented):
        self._movie = movie
        self._days_rented = days_rented

    @property
    def movie(self):
        return self._movie

    @property
    def days_rented(self):
        return self._days_rented

    @property
    def amount_for(self):
        this_amount = 0
        match self.movie.price_code:
            case Movie.REGULAR:
                this_amount += 2
                if self.days_rented > 2: this_amount += (self.days_rented - 2) * 1.5
            case Movie.NEW_RELEASE:
                this_amount += self.days_rented * 3
            case Movie.CHILDRENS:
                this_amount += 1.5
                if self.days_rented > 3: this_amount += (self.days_rented - 3) * 1.5
        return this_amount
