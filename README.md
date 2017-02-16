# JSON API на RoR
=================

### Использованные версии
	Ubuntu      '16.04'
	Ruby:       '2.3.1p112'
	Rails:      '5.0.1'
	PostgreSQL: '9.3.15'

Ссылка на репозиторий: [Github blog api](git@github.com:aturay/blog.git)     

### Install

Ввести в терминал
```bash
git clone git@github.com:aturay/blog.git && cd blog/
bundle && rails s
```
> Заполнение базы тестовыми данными
```
rails db:setup
```

### JSON API на RoR:
 
* [Список постов](http://localhost:3000/)

#### 1. Создать пост:
```bash
rails c
```
```ruby
uri = URI.parse("http://localhost:3000/set_post")
params = { 'title'=>"post_i", 'content'=>"content", 'user_login'=>"login_101)}", "ip"=>"192.168.0.50}" }
Net::HTTP.post_form(uri, params)
```

#### 2. Поставить оценку посту:
```bash
rails c
```
```ruby
uri = URI.parse("http://localhost:3000/set_rating")
parmas = { 'num' => 5, 'post_id' => 5 }
Net::HTTP.post_form(uri, parmas)
```

#### 3. Получить топ N постов по среднему рейтингу:

* Перейти по ссылке: [get_top_posts](http://localhost:3000/get_top_posts) #=> n=10
* Перейти по ссылке: [get_top_posts?n=100](http://localhost:3000/get_top_posts?n=100)
* Перейти по ссылке: [get_top_posts/100](http://localhost:3000/get_top_posts/100) 
```bash
curl http://localhost:3000/get_top_posts/101
```

#### 4. Получить список айпи, с которых постило несколько разных авторов:	
* Перейти по ссылке: [get_lists_ip](http://localhost:3000/get_lists_ip)
```bash
curl http://localhost:3000/get_lists_ip
```

#### RSpec - Tест
* Обязательное наличие спеков
```bash
rails s -e test
rspec
```

### SQL
* Переместится в текуший интерфейс командной строки
```bash
rails dbconsole
```

~~~
Ввести следующий блок sql:
```SQL
CREATE TEMP TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) 
VALUES (1), (1), (1), (2), (1), (3);

SELECT users.group_id as "Группа", 
	COUNT(users.id) as "Количество записей", MIN(users.id) as "Минимальный id"
FROM users 
GROUP BY users.group_id;
```
В результате:

| Группа | Количество записей | Минимальный id | 
| ------ |:------------------:| --------------:|
|      1 |                  4 |              1 |
|      3 |                  1 |              6 |
|      2 |                  1 |              4 |

(3 rows)

& SQL задание сделано неверно
~~~


<!-- ```sql
WITH q AS ( select group_id, row_number() over (order by id) - row_number() over (partition by group_id order by id) as res from users )

SELECT count(*) FROM q GROUP BY group_id, res

вычислить минимальный ID записи в группе

WITH q AS ( select id, group_id, row_number() over (order by id) - row_number() over (partition by group_id order by id) as res from users )

SELECT min(id) as min_id FROM q GROUP BY res, group_id ORDER BY min_id, group_id
```
 -->