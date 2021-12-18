require './book'
require './student'
require './teacher'
require './rental'

def main
  exit = false
  books = []
  people = []

  empty_msg = ''
  welcome_msg = 'Welcome to School Library App!'
  prompt_msg = 'Please choose an option by entering a number:'
  option1_msg = '1 - List all books'
  option2_msg = '2 - List all people'
  option3_msg = '3 - Create a person'
  option4_msg = '4 - Create a book'
  option5_msg = '5 - Create a rental'
  option6_msg = '6 - List all rentals for a given person id'
  option7_msg = '7 - Exit'
  beautifier = '-------------------------------'
  error_msg = 'Invalid input, please try again'
  beautifier2 = '-------------------------------------------'
  exit_msg = 'Thanks for using my app. See you next time!'

  puts empty_msg, welcome_msg
  while !exit
    puts empty_msg,
         prompt_msg,
         option1_msg,
         option2_msg,
         option3_msg,
         option4_msg,
         option5_msg,
         option6_msg,
         option7_msg
    input = gets.chomp
    case input
    when '0'
      puts '¯\(ツ)/¯'
    when '1'
      puts books.map { |book| "Title: \"#{book.title}\", Author: #{book.author}" }
    when '2'
      puts people.map { |person|
             "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
           }
    when '3'
      prompt_msg2 = 'Do you want to create a student (1) or a teacher (2)?'
      input_msg = ' [Input the number]: '
      print prompt_msg2, input_msg
      input2 = gets.chomp
      while !%w[1 2].include?(input2)
        print error_msg, input_msg
        input2 = gets.chomp
      end
      case input2
      when '1'
        print 'Age: '
        age = gets.chomp.to_i
        print 'Name: '
        name = gets.chomp
        print 'Has parent permission? [Y/N]: '
        parent_permission = gets.chomp.match(/[Yy]/) ? true : false
        people.push(Student.new(age, name, parent_permission: parent_permission))
        puts 'Student created successfully'
      when '2'
        print 'Age: '
        age = gets.chomp.to_i
        print 'Name: '
        name = gets.chomp
        print 'Specialization: '
        specialization = gets.chomp
        people.push(Teacher.new(age, name, specialization))
        puts 'Teacher created successfully'
      end
    when '4'
      print 'Title: '
      title = gets.chomp
      print 'Author: '
      author = gets.chomp
      books.push(Book.new(title, author))
      puts 'Book created successfully'
    when '5'
      puts 'Select a book from the following list by number'
      puts books.each_with_index.map { |book, index|
             "#{index + 1}) Title: \"#{book.title}\", Author: #{book.author}"
           }
      book = books[gets.chomp.to_i - 1]
      puts 'Select a person from the following list by number (not id)'
      puts people.each_with_index.map { |person, index|
             "#{index + 1}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
           }
      person = people[gets.chomp.to_i - 1]
      print 'Date: '
      date = gets.chomp
      Rental.new(date, book, person)
      puts 'Rental created successfully'
    when '6'
      print 'ID of person: '
      id = gets.chomp.to_i
      person =
        people
          .find { |person| person.id == id }
          &.rentals
          &.map do |rental|
            "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
          end
      if person.nil?
        beautifier3 = '----------------'
        puts empty_msg, beautifier3, 'Person not found', beautifier3
      else
        puts 'Rentals:', person
      end
    when '7'
      puts empty_msg, beautifier2, exit_msg, beautifier2
      exit = true
    else
      puts empty_msg, beautifier, error_msg, beautifier
    end
  end
end

main
