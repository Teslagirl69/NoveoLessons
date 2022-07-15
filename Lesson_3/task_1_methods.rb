# frozen_string_literal: true

# RANGE

# exclude_end?
# Возвращает true, если self исключает конечное значение; false иначе
p range_one = (0...9).exclude_end? # true
p range_two = (0..9).exclude_end? # false

# count
# Возвращает количество элементов
p range_three = (1..5).count # 5

# step, to_a
# Перебирает элементы с заданным шагом, если блок не задан, возвращает enumerator
# Возвращает массив, содержащий элементы из self, если это конечная коллекция
p range_four = ('A'...'J').step(2).to_a # ["A", "C", "E", "G", "I"]

# last
# Возвращает последний элемент self, если он существует (если передается без аргумента)
# C аргументом последние несколько элементов, начиная с минимального, вохвращает массив.
# reverse переворачивает массив
p range_five = (16...92).last(11).reverse # [91, 90, 89, 88, 87, 86, 85, 84, 83, 82, 81]
# max
# Возвращает максимальное значение self, используя метод <=>,
# Без аргумента и блока возвращает элемент self с максимальным значением.
# С заданным аргументом возвращает n элементов self с максимальным значением в массиве
p range_six = (100...167).max(5) # [166, 165, 164, 163, 162]

# ARRAY

# assoc
# Возвращает первый элемент в self, который является массивом, первый элемент которого == (obj)
p arr_one = [[1, 2, 3], %w[a h d u], [1, 'c', 11, 'g']].assoc('a') # ["a", "h", "d", "u"]

# combination
# Вызывает блок, если задан, с комбинациями элементов self; Порядок комбинаций не определен.
# Когда заданы блок и положительный целочисленный аргумент n (0 < n <= self.size)
# в диапазоне, вызывается блок со всеми комбинациями из n объектов self.
arr_two = %w[pen pineapple apple pan].combination(2) { |combination| p combination }
# ["pen", "pineapple"]
# ["pen", "apple"]
# ["pen", "pan"]
# ["pineapple", "apple"]
# ["pineapple", "pan"]
# ["apple", "pan"]

# delete_if
# Удаляет каждый элемент в self, для которого блок возвращает истинное значение; возвращает себя:
p arr_three = %w[to do to do to do to do to do too doo].delete_if { |word| word == 'to' }
# ["do", "do", "do", "do", "do", "too", "doo"]

# sample
# Возвращает случайные элементы из self. Когда аргументы не указаны, возвращает случайный элемент из self
p arr_four = %w[Lorem ipsum dolor sit amet].sample
# random element. for example "dolor"

# shuffle
# Возвращает новый массив с элементами самоперетасовки
p arr_five = %w[Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut
                labore et dolore magna aliqua.].shuffle.join(' ')
# random shuffled elements. for example "dolore et amet, adipiscing elit, do consectetur labore sed dolor ut sit eiusmod incididunt magna aliqua. ipsum tempor Lorem"

# HASH

# keys
# Возвращает новый массив, содержащий все ключи в self:
p hash_one = { apple: 16, pears: 64, kiwi: 43 }.keys.join(', ')
# "apple, pears, kiwi"

# select
# Возвращает новый хэш, записи которого являются теми, для которых блок возвращает истинное значение
hash_two = { Mike: 15, John: 19, Jessie: 16, Chloe: 18 }.select do |key, value|
  puts "#{key} is #{value} y.o." if value >= 18
end
# John is 19 y.o.
# Chloe is 18 y.o.

# invert
# Возвращает новый хэш, с каждой инвертированной парой ключ-значение (ключ становится значением, а значение ключом)
p hash_three = { Baby: (0..1.5), Toddler: (1.5..3), Preschooler: (3..5), Child: (6..9),
                 Preteen: (10..12.5) }.invert
# {0..1.5=>:Baby, 1.5..3=>:Toddler, 3..5=>:Preschooler, 6..9=>:Child, 10..12.5=>:Preteen}

# merge!
# Объединяет каждый из других хэшей в self; возвращает себя. Возвращает себя после того, как данные хэши будут объединены в него.
# Данные хэши объединяются слева направо. Каждая новая запись добавляется в конце.
# Каждое значение записи двойного ключа перезаписывает предыдущее значение.

hash_four = { Mike: 15, John: 18, Jessie: 16, Chloe: 17 }
hash_second = { John: 19, Jessie: 17, Chloe: 17, Nick: 16, Hannah: 17 }
hash_third = { Mike: 16,  Chloe: 18, Nick: 16, Hannah: 17 }

p hash_four.merge!(hash_second, hash_third)
# {:Mike=>16, :John=>19, :Jessie=>17, :Chloe=>18, :Nick=>16, :Hannah=>17

# values_at
# Возвращает новый массив, содержащий значения для заданных ключей
p hash_five = { Rock: 'AC/DC', Jazz: 'Zaz', Pop: 'Lady Gaga', Electronics: 'The Prodigy' }.values_at(
  :Pop, :Rock
)
# "Lady Gaga", "AC/DC"
