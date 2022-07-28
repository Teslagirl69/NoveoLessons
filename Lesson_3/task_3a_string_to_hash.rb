# frozen_string_literal: true

# а) Написать функцию, которая преобразует строку в хеш.
# Например, такая строка "a=1, b=2, c=3, d=4" станет { a: 1, b: 2, c: 3, d: 4}
def string_to_hash(str)
  arr = str.split(', ')
  arr.zip
  arr.map! do |sub_arr|
    sub_arr.split('=')
  end
  arr.to_h
end
p string_to_hash('a=1, b=2, c=3, d=4')
