# В приложении можно сделать 4 метода для обработки HTTP методов Get, Post, Patch, Delete.
# Ресурс, с которым предстоит работать - продукт, содержащий название, стоимость, количество и название производителя.
# То есть, это будет объект по типу Product (name, count, price, creator).
# Тогда, с помощью метода для обработки GET запроса следует отобразить весь список продуктов;
# с помощью POST запроса добавить новый продукт; с помощью PATCH обновить существующий,
# а с помощью DELETE удалить продукт. Продукты можно хранить в CSV файле.

require 'pry'
require 'sinatra'
require 'csv'

FILE_PATH = './data.csv'

get '/products' do
  csv = CSV.read(FILE_PATH)
  @data = csv[1..].sort_by { |array| array[0].to_i }
  @headers = csv[0]

  erb :list
end

get '/products/new' do
  erb :new
end

post '/products' do
  csv = CSV.read(FILE_PATH)
  ids = csv[1..].map do |row|
    row[0]
  end
  start_id = 1
  id = ids.empty? ? start_id : ids.max.next
  product = params[:product]
  csv = CSV.open(FILE_PATH, 'a+') do |row|
    row << [id, *product.values]
  end
  redirect '/products'
end

get '/products/:id/edit' do
  products = CSV.read(FILE_PATH)[1..]
  @product = products.find { |item| item[0] == params[:id] }

  erb :edit
end

patch '/products/:id' do
  id_to_edit = params[:id]
  csv = CSV.read(FILE_PATH)
  csv.delete_if { |row| row[0] == id_to_edit }
  row_to_edit = [id_to_edit, *params[:product].values]
  csv << row_to_edit
  CSV.open(FILE_PATH, 'w') do |row|
    headers = csv[0]
    row << headers
    csv[1..].each do |csv_row|
      row << csv_row
    end
  end
  redirect '/products'
end

delete '/products/:id' do
  id_to_delete = params[:id]
  csv = CSV.read(FILE_PATH)
  csv.delete_if { |row| row[0] == id_to_delete }
  CSV.open(FILE_PATH, 'w') do |row|
    headers = csv[0]
    row << headers
    csv[1..].each do |csv_row|
      row << csv_row
    end
  end
  redirect '/products'
end
