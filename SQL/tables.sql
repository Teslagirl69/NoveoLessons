--  Написать SQL скрипт, в котором будет выполняться создание следующих таблиц:

-- - authors(id: Primary key auto increment, first_name: not null, last_name: not null, age: not null)

-- - books(id: Primary key auto increment, title: not null, author_id: foreign key, copies_sold: not null)

-- Как результат, должен быть файл с расширением .sql, в котором будут следующие запросы:
-- - создание БД и таблиц
-- - добавление данных
-- - выполнение заданных запросов
-- - удаление данных и БД


CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  age INT NOT NULL
);


CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  author_id INT,
  CONSTRAINT fk_author
  FOREIGN KEY(author_id)
  REFERENCES authors(id),
  copies_sold INT NOT NULL
);



INSERT INTO authors (first_name, last_name, age)
VALUES('Stephen', 'King', 74);

INSERT INTO authors (first_name, last_name, age)
VALUES('George', 'Martin', 73);

INSERT INTO authors (first_name, last_name, age)
VALUES('Haruki', 'Murakami', 73);


INSERT INTO books (title, copies_sold, author_id)
VALUES('The Shining', 692208, 1);
INSERT INTO books (title, copies_sold, author_id)
VALUES('Carrie', 320916, 1);
INSERT INTO books (title, copies_sold, author_id)
VALUES('Salems Lot', 298080, 1);


INSERT INTO books (title, copies_sold, author_id)
VALUES('A Song of Ice and Fire', 90000000, 2);

INSERT INTO books (title, copies_sold, author_id)
VALUES('Kafka on the shore', 1459753, 3);
INSERT INTO books (title, copies_sold, author_id)
VALUES('Norwegian Wood', 11160000, 3);

-- - Выбрать авторов, у которых длина first_name более 6-ти символов;

SELECT first_name,length(first_name)
FROM authors
WHERE length(first_name)>6;

-- - Подсчитать количество авторов по каждому возрасту: результатом select должны быть две колонки - age, authors_count;

SELECT age, count( * ) FROM authors GROUP BY age;
-- - Выбрать и отобразить 3 самые продаваемые книги (наибольшее значение колонки copies_sold);

SELECT copies_sold, title, author_id
FROM books
ORDER BY copies_sold DESC
LIMIT 3;

-- - Отобразить информацию об авторах, дополнительно указав количество написанных ими книг.

SELECT authors.*, count(books.id)
FROM authors
LEFT JOIN books ON authors.id = books.author_id
group by authors.id;

alter table books drop constraint fk_author;
drop table authors;
drop table books;
