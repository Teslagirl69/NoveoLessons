# 2. В ruby есть safe navigation operator (&.),
#  который позволяет избежать ошибки NoMethodError
#   для nil-объекта: some_object&.even? (some_object = 1 => true; some_object = nil => nil).
#   Данный оператор удобен, когда есть вероятность, что объект будет nil,
#   но дополнительно проверять это будет затратно и неудобно. Тем не менее,
#   этот оператор не исключает ошибок в ситуации, когда метод не существует
#   для объектов другого класса: false&.even? (NoMethodError).
#   Целью данной задачи является реализация такого метода, который будет возвращать nil,
#   если для объекта нельзя вызвать указанный метод. Метод должен находиться в модуле и получать параметром блок.
# Тестовые варианты
module Tryable
  def try
    # block.call(self)
    yield self
  rescue NoMethodError
    nil
  end
end

class Integer
  include Tryable
end

class FalseClass
  include Tryable
end

class TrueClass
  include Tryable
end
# Your code here

puts false.try { even? } # nil
puts false.try(&:even?) # nil
puts 2.try(&:even?) # true
puts 1.try { |obj| obj + 1 } # 2
puts true.try { |obj| obj + 1 } # nil
puts 1.try { |obj| obj + '' } # it still should raise error “String can't be coerced into Integer”
