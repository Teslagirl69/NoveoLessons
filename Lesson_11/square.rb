
# Требуется сортировать фигуры по их площади.
# Из фигур есть: Square (площадь - “квадрат” сторон),
# Rectangle (площадь - ширина * длина),
# Triangle (основание * высоту / 2),
# Круг (pi * (R^2)), и произвольная
# CustomShape (площадь просто задается).

# Пример того, как должна выполняться сортировка элементов массива, если все элементы в этом массиве - фигуры
class Square
  attr_reader :side
  def initialize(side)
    @side = side
  end
  def square
    @sq = side**2
  end
  def to_s
   "Square with area:      #{@sq.ceil(2)}"
  end
end

class Rectangle
 attr_reader :width, :length
  def initialize(width, length)
    @width = width
    @length = length
  end
  def square
    @sq = width * length
  end
  def to_s
   "Rectangle with area:   #{@sq.ceil(2)}"
  end

end
class Triangle

attr_reader :base, :height
  def initialize(base, height)
    @base = base
    @height = height
  end
  def square
    @sq = base * height / 2
  end
def to_s
   "Triangle with area:    #{@sq.ceil(2)}"
  end
end


class Circle
  include Math
attr_reader :radius
  def initialize(radius)
    @radius = radius
  end
  def square
    @sq = PI * (radius**2)
  end
  def to_s
   "Circle with area:      #{@sq.ceil(2)}"
  end

end


class CustomShape
attr_reader :square
  def initialize(square)
    @square = square
  end
  def to_s
   "CustomShape with area: #{@square.ceil(2)}"
  end

end

shapes = [Square.new(4), Rectangle.new(1,4), Triangle.new(2,6), Circle.new(3), CustomShape.new(11)]

puts shapes.sort {|a, b| b.square <=> a.square  }
