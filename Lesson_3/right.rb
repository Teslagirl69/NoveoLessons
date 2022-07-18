def ranks(arr)
  b = arr.sort.reverse
  arr.map { |elem| b.index(elem) + 1 }
end
p ranks([3,3,3,3,3,5,1])
