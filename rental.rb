class Rental
  attr_reader :book, :person
  attr_accessor :date

  def initialize(date, book, person)
    @date = date
    @book = book
    book.rentals << self
    @person = person
    person.rentals << self
  end

  def book=(book)
    return unless book != @book

    @book.rentals.delete(self)
    @book = book
    @book.rentals.push(self)
  end

  def person=(person)
    return unless person != @person

    @person.rentals.delete(self)
    @person = person
    @person.rentals.push(self)
  end
end
