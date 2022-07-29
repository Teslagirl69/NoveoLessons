# frozen_string_literal: true

# Нужно реализовать класс VersionManager. Конструктор опционально должен принимать строку - версию.
# Допустимые варианты строки: “{major}” (“1”), “{major}.{minor}” (“1.1”), “{major}.{minor}.{patch}” (“1.1.1”).
# В варианте типа "1.1.1.1.1" оставить только первые три значения версии.
# Если часть версии - не целое число (напр. "а.4.е"), то генерировать ошибку.
# Если версия не указана, то значение по умолчанию - “0.0.1”.

# Тестовые варианты

# vm = VersionManager.new

# vm.major! # увеличивает мажорную версию, устанавливая минорную и патч в 0 (напр. “2.0.0”)
# vm.minor! # увеличивает минорную версию, устанавливая патч в 0 (напр. “2.1.0”)
# vm.patch! # увеличивает патч версию (напр. “2.1.1”)

# vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
# vm.release # возвращает текущую версию в формате “{major}.{minor}.{patch}”
require 'pry'
class VersionManager
  attr_accessor :version, :major, :minor, :patch, :actions

  def initialize(version = '0.0.1')
    @version = version
    raise 'Invalid version' if arr = version.split('.').any?(/\D/)

    @major, @minor, @patch = version.split('.')[0..2].map(&:to_i)
    @actions = []
  end

  def major!
    @major += 1
    @minor = 0
    @patch = 0
    actions << 'major'
  end

  def minor!
    @minor += 1
    @patch = 0
    actions << 'minor'
  end

  def patch!
    @patch += 1
    actions << 'patch'
  end

   def rollback!
     if actions.last == 'patch'
      @patch -= 1
    elsif actions.last == 'minor'
      @patch = 0
      @minor -= 1
    elsif actions.last == 'major'
      @patch = 0
      @minor = 0
      @major -= 1
    else

      raise 'Can not rollback to previous version'
    end
   end

  def release
    puts "#{major}.#{minor}.#{patch}"
  end
end

vm = VersionManager.new
 vm.major! # увеличивает мажорную версию, устанавливая минорную и патч в 0 (напр. “2.0.0”)
 vm.minor! # увеличивает минорную версию, устанавливая патч в 0 (напр. “2.1.0”)
 vm.patch! # увеличивает патч версию (напр. “2.1.1”)
 vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
 vm.release # возвращает текущую версию в формате “{major}.{minor}.{patch}”
