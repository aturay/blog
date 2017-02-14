# JSON API на RoR
=================

### Использованные версии
	Ruby:       '2.3.1p112'
	Rails:      '5.0.1'
	PostgreSQL: '9.3.15'

Ссылка на репозиторий: [Github blog api](git@github.com:aturay/blog.git)     

### Install

Ввести в терминал `Ctrl + Alt + t`: 
```bash
git clone git@github.com:aturay/blog.git && cd blog/
bundle && rails db:create && rails db:migrate
rails s
```

> В новой вкладке (`Ctrl + Shift + t`) набрать `rails db:setup` для заплнение базы тестовыми данными
```bash
rails db:setup
```

### JSON API на RoR:

* [Админка](http://localhost:3000/admin)
	__log:__  `admin@admin.com`
	__pass:__ `password`

 
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

#### RSpec
* Обязательное наличие спеков
```bash
rspec
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


1. Админку делать не требовалось.
2. Вся логика в контроллерах.
3. В запросе на топ посты наблюдается SQL-инъекция.
4. Топ посты: конкурентность ок, 
	но запрос будет тормозить на больших объёмах данных, 
	т.к. нет индексов. 
	Запрос на айпи уже на 200к записей у меня занимает 300+ мс. 
	(В задании указано, что должно быть менее 100мс).
5. Айпи: наблюдается N+1 запрос, опять-таки будет тормозить.
6. Гонять спеки на девелопмент-базе так себе решение, 
	все-таки тестовая база должна накатываться 
	перед каждым прогоном тестов и наполняться заранее известными данными.

В дополнение
1. SQL задание сделано неверно
2. спеки не тестируют порядок выдачи записей в списках айпи и постов
3. Рейтинг будет возвращать неверное значение рейтинга в ответ на запрос set_rating так как другой инстанс может создать запись рейтинга до момента выполнения запроса о среднем значении (при большом количестве конкуррентных запросов)
