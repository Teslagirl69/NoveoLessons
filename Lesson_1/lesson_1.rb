# frozen_string_literal: true

def sum(arr)
  total = 0

  if arr == []
    0
  else
    total + arr.shift + sum(arr)
  end
end
puts sum([1, 2, 3, 4])
