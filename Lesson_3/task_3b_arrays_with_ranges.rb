# frozen_string_literal: true

# б) Дан массив с числами, необходимо вернуть массив в проставленными рангами для этих чисел.
# Наибольшее число имеет ранг 1, следующее за ним ранг 2 и так далее.
# Одинаковые числа имеют одинаковый ранг, но при этом счетчик ранга увеличивается для следующего отличающего числа
# * ranks([9,3,6,10]) = [2,4,3,1]
# * ranks([3,3,3,3,3,5,1]) = [2,2,2,2,2,1,7]

def ranks(arr)
  sorted_arr = arr.sort.uniq.reverse
  maped_arr = arr.map { |e| sorted_arr.index(e) + 1 }

  maped_hash = maped_arr.group_by(&:dup)
  sorted_hash = maped_hash.sort.to_h

  arr_counts = []
  count = 0

  sorted_hash.each_value do |v|
    arr_counts << count += v.size
  end

  arr_counts.zip

  transformed_hash = sorted_hash.transform_values.with_index do |value, index|
    value.size < 2 ? value = arr_counts[index] : value
  end

  ranked_hash = maped_hash.merge(transformed_hash)
  ranked_hash.values.flatten
end

arr_first = [9, 3, 6, 10]
arr_second = [3, 3, 3, 3, 3, 5, 1]
arr_third = [2, 3, 3, 3, 3, 3, 5, 8, 1]
puts "Array #{arr_first} transforms to ranked array: #{ranks(arr_first)}"
puts "Array #{arr_second} transforms to ranked array: #{ranks(arr_second)}"
puts "Array #{arr_third} transforms to ranked array: #{ranks(arr_third)}"
