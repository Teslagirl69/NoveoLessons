# frozen_string_literal: true

# Нужно реализовать класс Vector с соответствующими методами по сложению, вычитанию векторов.
# Если оперируемые векторы разной длины, то это должна быть ошибка или nil результат.

# a = Vector.new([1, 2, 3])
# b = Vector.new([3, 4, 5])
# c = Vector.new([5, 6, 7, 8])

# a.add(b)      # should return a new Vector([4, 6, 8])
# a.subtract(b) # should return a new Vector([-2, -2, -2])
# a.dot(b)      # should return 1*3 + 2*4 + 3*5 = 26
# a.norm()      # should return sqrt(1^2 + 2^2 + 3^2) = sqrt(14)
# a.add(c)      # throws an nil
# a.to_s        # (1, 2, 3)

class Vector
  attr_reader :nodes

  def initialize(nodes)
    @nodes = nodes.is_a?(Array) ? nodes : nil
  end

  def add(other_vector)

   vector_nodes = if other_vector.nodes.size != nodes.size
    return puts ' Vectors have different length try again'
    else
      result = nodes.map.with_index do |node, index|
        node + other_vector.nodes[index]
      end

    end
    Vector.new(vector_nodes)
  end

  def subtract(vect)
     vector_nodes = if vect.nodes.size != nodes.size
     return puts ' Vectors have different length try again'
    else
      result = nodes.map.with_index do |node, index|
        node - vect.nodes[index]
      end
    end
    Vector.new(vector_nodes)
  end

  def norm
    sq_arr = []
    nodes.each do |elem|
      elem **= 2
      sq_arr << elem
    end
    res = sq_arr.sum
    Math.sqrt(res)
  end

  def dot(other_vector)
    result = []
    if other_vector.nodes.size != nodes.size
      puts ' Vectors have different length try again'
    else
      result = nodes.map.with_index do |node, index|
        node * other_vector.nodes[index]
      end
      result.sum
    end
  end

  def to_s
    "(#{nodes.join(', ')})"
  end
end

a = Vector.new([1, 2, 3])
b = Vector.new([3, 4, 5])
c = Vector.new([5, 6, 7, 8])

p a.add(b)      # should return a new Vector([4, 6, 8])
p a.subtract(b) # should return a new Vector([-2, -2, -2])
p a.dot(b)      # should return 1*3 + 2*4 + 3*5 = 26
p a.norm # should return sqrt(1^2 + 2^2 + 3^2) = sqrt(14)
p a.add(c)      # throws an nil
p a.to_s        # (1, 2, 3)
