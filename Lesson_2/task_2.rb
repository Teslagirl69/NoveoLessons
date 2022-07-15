=begin
2. Считать "#" символом для удаления прошлого символа. Это значит, что строка "a#bc#d" преобразуется к виду "bd".
Необходимо написать метод для обработки строки с "#" символами.


Тестовые варианты:
"abc#d##c"      ==>  "ac"
"abc##d######"  ==>  ""
"#######"       ==>  ""
""              ==>  ""
=end

regex = Regexp.new('[a-z]#')

def chomp_string(str)
  str.gsub!(regex, '')
  chomp_string(str) if str.match?(regex)
  str.gsub('#', '')
end

string = gets.chomp

puts chomp_string(string)
