class Employee
  attr_accessor :boss
  attr_reader :name, :title, :employees, :salary

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @boss = boss
    @salary = salary
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    salary_sum = 0

    employees.each do |employee|
      salary_sum += employee.salary
      salary_sum += employee.bonus(1) if employee.is_a?(Manager)
    end

    salary_sum * multiplier
  end

  def add_employee(employee)
    employees << employee
    employee.boss = self
  end
end
