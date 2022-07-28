# frozen_string_literal: true

# Нужно реализовать класс HashWithIndifferentAccess, который позволит обращаться к ключу-строке по символу и наоборот.
# Для это следует расширить существующий класс Hash. Также добавить метод для перехода от обычного хеша к модифицированному.

# Тестовые варианты

# h = { a: 'apple' }.with_indifferent_access
# puts h['a'] # => apple
# hash[:foo] = 'bar'
# puts hash['foo']  # => bar

class HashWithIndifferentAccess < Hash
  # key == :a => 'a'; key == 'a' => 'a'; real_key = :a
  def self.[](key)
    # self[key.respond_to?(:to_s) ? key.to_s : key]
    # self[key.respond_to?(:to_sym) ? key.to_sym : key]
  end
end

class Hash
  # : return HashWithIndifferentAccess
  def with_indifferent_access
    HashWithIndifferentAccess.new(self)
  end
end

h = { a: 'apple' }.with_indifferent_access
puts h['a']
hash[:foo] = 'bar'
puts hash['foo']

# simple_hash = { a: 'apple', 'b': 1 } # simple_hash.class => Hash
# hash_with_indif_acc = { a: 'apple', 'b': 1 }.with_indifferent_access # hash_with_indif_acc.class => HashWithIndifferentAccess

# def take_a(hash)
#   hash_with_indif_acc[:b] => # nil
# end

# hash_with_indif_acc.get_key(:a) == hash_with_indif_acc[:a] == hash_with_indif_acc.get_key('a')
# hash_with_indif_acc.get_key('b') == hash_with_indif_acc['b'] == hash_with_indif_acc.get_key(:b)
