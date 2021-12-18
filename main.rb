require './book'
require './student'
require './teacher'
require './rental'

def beautify(str)
  ['', ''.rjust(str.length, '-'), str, ''.rjust(str.length, '-')]
end

def list_books(books)
  books.map { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
end

def list_people(people)
  people.map do |person|
    puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
end

def create_student(people)
  print 'Age: '
  age = gets.chomp.to_i
  print 'Name: '
  name = gets.chomp
  print 'Has parent permission? [Y/N]: '
  parent_permission = gets.chomp.match(/[Yy]/) ? true : false
  people.push(Student.new(age, name, parent_permission: parent_permission))
  puts 'Student created successfully'
end

def create_teacher(people)
  print 'Age: '
  age = gets.chomp.to_i
  print 'Name: '
  name = gets.chomp
  print 'Specialization: '
  specialization = gets.chomp
  people.push(Teacher.new(age, name, specialization))
  puts 'Teacher created successfully'
end

def create_person(people)
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  input2 = gets.chomp
  until %w[1 2].include?(input2)
    print 'Invalid input, please try again. [Input the number]: '
    input2 = gets.chomp
  end
  case input2
  when '1'
    create_student(people)
  when '2'
    create_teacher(people)
  end
end

def create_book(books)
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp
  books.push(Book.new(title, author))
  puts 'Book created successfully'
end

def create_rental(books, people)
  puts 'Select a book from the following list by number'
  books.each_with_index.map do |book, index|
    puts "#{index + 1}) Title: \"#{book.title}\", Author: #{book.author}"
  end
  book = books[gets.chomp.to_i - 1]
  puts 'Select a person from the following list by number (not id)'
  people.each_with_index.map do |person, index|
    puts "#{index + 1}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
  person = people[gets.chomp.to_i - 1]
  print 'Date: '
  date = gets.chomp
  Rental.new(date, book, person)
  puts 'Rental created successfully'
end

def list_rentals(people)
  print 'ID of person: '
  id = gets.chomp.to_i
  rentals_for_id =
    people
      .find { |person| person.id == id }
      &.rentals
      &.map do |rental|
        "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
      end
  if rentals_for_id.nil?
    puts beautify('Person not found')
  else
    puts 'Rentals:', rentals_for_id
  end
end

def make_decision(input, books, people)
  case input
  when '1'
    list_books(books)
  when '2'
    list_people(people)
  when '3'
    create_person(people)
  when '4'
    create_book(books)
  when '5'
    create_rental(books, people)
  when '6'
    list_rentals(people)
  else
    puts beautify('Invalid input, please try again')
  end
end

def main
  books = []
  people = []

  puts '', 'Welcome to School Library App!'
  loop do
    puts '',
         'Please choose an option by entering a number:',
         '1 - List all books',
         '2 - List all people',
         '3 - Create a person',
         '4 - Create a book',
         '5 - Create a rental',
         '6 - List all rentals for a given person id',
         '7 - Exit'
    input = gets.chomp
    if input == '7'
      puts beautify('Thanks for using my app. See you next time!')
      break
    end
    make_decision(input, books, people)
  end
end

main
