# frozen_string_literal: true

# Требуется сортировать фигуры по их площади.
# Из фигур есть: Square (площадь - “квадрат” сторон),
# Rectangle (площадь - ширина * длина),
# Triangle (основание * высоту / 2),
# Круг (pi * (R^2)), и произвольная
# CustomShape (площадь просто задается).
# Пример того, как должна выполняться сортировка элементов массива, если все элементы в этом массиве - фигуры

class Shape
  attr_reader :square

  include Comparable

  def <=>(other)
    other.square <=> square
  end
end

class Square < Shape
  def initialize(side)
    @side = side
  end

  def square
    @side**2
  end
end

class Rectangle < Shape
  def initialize(width, length)
    @width = width
    @length = length
  end

  def square
    @width * @length
  end
end

class Triangle < Shape
  def initialize(base, height)
    @base = base
    @height = height
  end

  def square
    @base * @height / 2
  end
end

class Circle < Shape
  def initialize(radius)
    @radius = radius
  end

  def square
    Math::PI * (@radius**2)
  end
end

class CustomShape < Shape
  attr_reader :square

  def initialize(square)
    @square = square
  end
end

shapes = [Square.new(4), Rectangle.new(1, 4), Triangle.new(2, 6), Circle.new(3), CustomShape.new(11)]

puts shapes.sort
