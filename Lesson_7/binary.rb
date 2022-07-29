# frozen_string_literal: true

# Нужно реализовать класс BinaryTree, в котором можно будет хранить элементы Node.
# У класса должны быть методы для добавления элемента в дерево, удаления и поиска элемента.
# За тип данных можно принять Integer

# Тестовые варианты

# tree = BinaryTree.new

# tree.add(10) #=> 10
# tree.add(20) #=> 20
# tree.add(30) #=> 30

# tree.delete(10) #=> 10
# tree.delete(25) #=> nil

# tree.find(20) #=> 20
# tree.find(26) #=> nil
require 'pry'
class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def add(other_value)
    iter = self

    until iter.nil?
      prev = iter
      iter = iter.value < other_value ? iter.right : iter.left
    end

    if prev.value < other_value
      prev.right = Node.new(other_value)
    else
      prev.left = Node.new(other_value)
    end
  end

  protected

  def add_recursive(other_value)
    if other_value < value
      left.nil? ? @left = Node.new(value) : left.add_recursive(other_value)
    elsif other_value > value
      right.nil? ? @right = Node.new(value) : right.add_recursive(other_value)
    end
  end

  def to_s
    puts "Value: #{value}"
  end
end

class BinaryTree
  attr_accessor :root

  def initialize
    root = nil
  end

  def add(value)
    iter = root

    if iter.nil?
      @root = Node.new(value)
    else
      root.add(value)
    end
  end

  def find(value)
    return value if root.value == value

    find_recursive(root, value)
  end

  def find_recursive(node, value)
    return if node.nil?
    return value if node.value == value

    found = false
    found = find_recursive(node.left, value)
    return value if node.value == value

    value = find_recursive(node.right, value)
  end

  def min_value_node(node)
    current = node
    until current.left.nil?
      current = current.left
      return current
    end
  end

  def delete(value)
    return if value.nil?
    return "Wrong node: #{value}" if value != find(value)

    if value == root.value
      root.value = root.right.value
      value
    else
      delete_recursive(root, value)
    end
  end

  def delete_recursive(root = self, value)
    if value > root.value
      root.right = delete_recursive(root.right, value)
    elsif value < root.value
      root.left = delete_recursive(root.left, value)
    else # i.e. value == root.value
      root = if root.left.nil? # also catches cases when both child nodes are empty
               root.right
             elsif root.right.nil?
               root.left
             else
               shift_values(root)
             end
    end
    root
  end

  def shift_values(root)
    root.value = get_next_value(root.right)
    root.right = right_subtree_without_next_value(root.right)
    root
  end

  def get_next_value(root)
    if root.left.nil?
      root.value
    else
      get_next_value(root.left)
    end
  end

  def right_subtree_without_next_value(root)
    if root.left.nil?
      return root.right
    else
      root.left = right_subtree_without_next_value(root.left)
    end

    root
  end

  def to_s
    inspect
  end
end

tree = BinaryTree.new

puts tree.add(10) #=> 10
puts tree.add(20) #=> 20
puts tree.add(30) #=> 30
puts tree.find(10) #=> 10
puts tree.find(20) #=> 20
puts tree.find(30) #=> 30
puts tree.find(26) #=>

puts tree.delete(10) #=> 10

puts tree.delete(25) #=> nil
puts tree
# #<BinaryTree:0x000000013a10b0b8 @root=#<Node:0x000000013a10abe0 @value=10, @left=nil, @right=#<Node:0x000000013a10a8e8 @value=20, @left=nil, @right=#<Node:0x000000013a10a848 @value=30, @left=nil, @right=#<Node:0x000000013a10a640 @value=40, @left=#<Node:0x000000013a10a528 @value=34, @left=nil, @right=nil>, @right=nil>>>>>
