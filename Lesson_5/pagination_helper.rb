# 1. Нужно реализовать класс PaginationHelper, который позволит пагинировать массив. Класс получает в конструктор сам массив и число элементов для дробления массива.

# Пример работы:
# helper = PaginationHelper.new(['a','b','c','d','e','f'], 4)

# helper.page_count() # 2
# helper.item_count() # 6
# helper.page_item_count(0)  # 4, т.к нумерация страниц с 0
# helper.page_item_count(1) # 2, последняя страница содержит 2 элемента
# helper.page_item_count(2) # -1

# # page_index принимает индекс элемента и возвращает страницу, на которой этот элемент находится

# helper.page_index(5) # 1
# helper.page_index(2) # 0
# helper.page_index(20) # -1
# helper.page_index(-10) # -1

require "pry"

class PaginationHelper

attr_reader :array, :per_page

def initialize (array, per_page)
  @array = array
  @per_page = per_page
end

def page_count
  (array.size / per_page.to_f).ceil
end

def item_count
  array.size
end

def page_item_count(page)
# binding.pry
  if page > page_count - 1
    return -1
  else
    array.each_slice(per_page).to_a[page].size
  end
end

def page_index(element_index)
  element = array[element_index]
  paged_array =  array.each_slice(per_page).to_a
  indexed = paged_array.each.with_object([]).with_index do | (page, arr), index|
    arr.push(index) if page.include?(element)
   end
  end

  indexed.first || -1
end

end


helper = PaginationHelper.new(['a','b','c','d','e','f'], 4)
# p helper.page_count()
# p helper.item_count
# p helper.page_item_count(0)  # 4, т.к нумерация страниц с 0
# p helper.page_item_count(1) # 2, последняя страница содержит 2 элемента
# p helper.page_item_count(2)

p helper.page_index(5) # 1
 p helper.page_index(2) # 0
 p helper.page_index(20) # -1
 p helper.page_index(-10) # -1
