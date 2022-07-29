# 2-ый вариант использования
#
# str1 = 'string one'
# str2 = 'string two'
# ....
# str1.capitalize_each_word => "String One"
# str2.capitalize_each_word => NoMethodErro

module StringHelper
  def capitalize_each_word
    puts split(' ').map(&:capitalize).join(' ')
  end
end

class String
end

str1 = 'string one'
str2 = 'string two'
str1.extend StringHelper
str1.capitalize_each_word  # "String One"
str2.capitalize_each_word
