# JSON API на RoR
=================

### Использованные версии
	Ruby:       '2.3.1p112'
	Rails:      '5.0.1'
	PostgreSQL: '9.3.15'

Ссылка на репозиторий: [Github blog api](git@github.com:aturay/blog.git)     

### Install

Ввести в термин: 
```bash
git clone git@github.com:aturay/blog.git && cd blog/
bundle && rails db:create && rails db:migrate
rails s
```

> В новой вкладке (`ctrl + shift + t`) набрать `rails db:setup` для заплнение базы тестовыми данными
```bash
rails db:setup
```

### JSON API на RoR:

* [Админка](http://localhost:3000/admin)
+ __log:__  `admin@admin.com`
+ __pass:__ `password`

 
* [Посмотреть в браузере](http://localhost:3000/)

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

### SQL
* Переместится в текуший интерфейс командной строки:
```bash
rails dbconsole
```

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

