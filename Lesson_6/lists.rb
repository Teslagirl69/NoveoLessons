# frozen_string_literal: true

# 2. Нужно реализовать класс LinkedList, в котором можно будет хранить элементы класса Node.
# У класса должны быть методы для добавления в конец и произвольную позицию, удаления и поиска элемента.
# Классы должны быть описаны в разных файлах. Примеры:

require 'pry'
require_relative './node'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head
      @tail.next = node
    else
      @head = node
    end
    @tail = node
  end

  def append_after(point, value)
    node = find(point)

    return unless node

    previous = node.next
    node.next = Node.new(value)
    node.next.next = previous
  end

  def find(value)
    node = @head

    return node if node.value == value
    return false unless node.next

    while (node = node.next)
      return node if node.value == value
    end
  end

  def delete(value)
    node = @head
    if node.value == value
      @head = @head.next
    else
      node = @head
      node = node.next while !node.nil? && !node.next.nil? && (node.next.value != value)

      node.next = node.next.next if !node.nil? && !node.next.nil?
    end
  end

  def to_s
    node = @head
    arr = []
    until node.next.nil?
      arr.push(node.value.to_s)
      node = node.next
    end
    arr.push(node.value.to_s)
    joined = arr.join('->')
    "Linked list is: #{joined}"
  end
end

list = LinkedList.new

list.append(3)
list.append(5)
list.append(10)
puts list #=> (3, 5, 10)

list.append_after(3, 15)
puts list #=> (3, 15, 5, 10)
list.append_after(10, 25)
puts list #=> (3, 15, 5, 10, 25)

list.delete(10)
puts list.find(25)
puts list
