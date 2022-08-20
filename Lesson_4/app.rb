# frozen_string_literal: true

# Нужно реализовать класс HashWithIndifferentAccess, который позволит обращаться к ключу-строке по символу и наоборот.
# Для это следует расширить существующий класс Hash. Также добавить метод для перехода от обычного хеша к модифицированному.

class HashWithIndifferentAccess < Hash
  def [](key)
    include?(key) ? super(key) : nil

    return super(key.to_s) if include?(key.to_s)
    return super(key.to_sym) if include?(key.to_sym)
    return super(key.to_i) if include?(key.to_i)
  end
end

class Hash
  def with_indifferent_access
    HashWithIndifferentAccess[self]
  end
end

h = { a: 'apple' }.with_indifferent_access
puts h['a'] # => apple
h[:foo] = 'bar'
puts h['foo'] # => bar
h[1] = 2
puts h['1'] # => 2
puts h
