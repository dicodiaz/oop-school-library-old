class Classroom
  attr_reader :students
  attr_accessor :label

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    student.classroom = self
  end
end

# Tests

require './student'

classroom = Classroom.new('11-A')
classroom2 = Classroom.new('11-B')
student = Student.new(classroom, 14, 'Mike')
student2 = Student.new(classroom, 15, 'Steve')
puts 'Classroom 11-A:', classroom.students.map(&:name)
classroom2.add_student(student2) # Move student2 from 11-A to 11-B
puts 'Move Steve from 11-A to 11-B'
puts 'Classroom 11-A:', classroom.students.map(&:name)
puts 'Classroom 11-B:', classroom2.students.map(&:name)
classroom2.add_student(student) # Move student from 11-A to 11-B
puts 'Move Mike from 11-A to 11-B'
puts 'Classroom 11-B:', classroom2.students.map(&:name)
