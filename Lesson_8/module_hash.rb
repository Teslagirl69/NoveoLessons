# frozen_string_literal: true

# Снова вернемся к задаче с хешом, которую мы делали, когда строковые и символьные ключи доступны по одинаковым ключам.
# Решить только надо теперь с использованием модуля, который будет дополнять текущий хеш дополнительным функционалом:


module IndifferentAccessable
  def [](key)
    return super(key.to_s) if key.is_a?(Symbol) && include?(key.to_s)
    return super(key.to_sym) if key.is_a?(String) && include?(key.to_sym)
    return super(key.to_i) if key.is_a?(Integer) && include?(key.to_i)

    super(key)
  end
end

class Hash
  def make_indifferent_accessable!
    self.singleton_class.prepend IndifferentAccessable
    self
  end
end

hash1 = { a: 1, 'b' => 2, 1 => 3 }.make_indifferent_accessable! # можно вызвать метод так
puts hash1['a'] #=> 1
puts hash1[:b] #=> 2
puts hash1[1] #=> 3

hash2 = { z: 5, 't' => 7, 9 => 2 }
puts hash2['z']

hash3 = { d: 3, true => 'True' }
puts hash3.make_indifferent_accessable!['d'] #=> 3 # можно и так, сразу обращаться по ключу
puts hash3[true] #=> True

