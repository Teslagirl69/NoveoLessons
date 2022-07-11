=begin
1. Дано число n, необходимо найти побитовое ИЛИ (сложение) для цепочки чисел от 0 до n. То есть, складывать
 эти числа надо в их двоичной вариации. Что-то типа 0 + 1 + 2 + 3 = 3, так как 00 + 01 + 10 + 11 = 11
Тестовые варианты:
* Input: 0, output = 0
* Input: 1, output = 1
* Input: 4, output = 7
* Input: 5, output = 7
* Input: 6, output = 7
* Input: 7, output = 7
=end

number = gets.chomp.to_i

def get_sum(number)
  q = 0..number
  sum = 0b00
    q.each do |num|
    sum = (sum | num)
    end
  sum
end
puts get_sum(number)
