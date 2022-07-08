# frozen_string_literal: true

def sum(arr)
  if arr == []
    0
  else
  arr.shift + sum(arr)
  end
end
puts sum([1, 2, 3, 4, 5])
