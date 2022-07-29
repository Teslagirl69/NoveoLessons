# Создать модуль с набором полезных методов для строк. Например, чтобы модуль содержал метод capitalize_each_word:
# 'some new string'.capitalize_each_word #=> "Some New String"
#
# 1-ый вариант использования
#
# 'string one'.capitalize_each_word
# 'string two'.capitalize_each_word
#

module StringHelper
  def capitalize_each_word
    puts split(' ').map(&:capitalize).join(' ')
  end
end

class String
  include StringHelper
end

'string one'.capitalize_each_word
'string two'.capitalize_each_word
'Lorem ipsum dolor sit amet'.capitalize_each_word
