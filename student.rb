require './person'

class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', classroom = nil, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students << self unless classroom.nil?
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    return unless classroom != @classroom

    @classroom.students.delete(self)
    @classroom = classroom
    @classroom.students.push(self)
  end
end
