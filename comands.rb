Ruby:       '2.3.1p112'
Rails:      '5.0.1'
PostgreSQL: '9.3.15'
Github:     'git@github.com:aturay/blog.git'


gem install rails --no-ri --no-rdoc
rails new blog -d postgresql && cd blog/

# Список добавленных гемов
gem 'jquery-rails', '~> 4.2.1'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'haml'
gem 'kaminari'
gem 'devise' #,'~> 4.2.0' || ,'~> 3.0.3' `
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'rspec-rails', '~> 3.5'
bundle

# generate active admin
rails g devise:install
rails g active_admin:install
rails g kaminari:config
rails db:create && rails db:migrate

AdminUser.new(email: 'admin@admin.com', password: 'password').save()



# Айпи
rails g model Ip --no-timestamps
  ip:string
  has_many :users
  has_many :posts
rails g active_admin:resource Ip


# Юзер
rails g model User --no-timestamps
  login:string
  ip:references
  has_many :posts
rails g active_admin:resource User


# Пост
rails g scaffold Post --no-timestamps
  title:string
  content:text
  user:references
  ip:references
  has_many :ratings
rails g active_admin:resource Post


# Оценка поста
rails g model Rating --no-timestamps
  num:integer # collection: [1, 2, 3, 4, 5]
  post:references
rails g active_admin:resource Rating

rails db:setup

# Админка
http://localhost:3000/admin
log:  admin@admin.com
pass: password


# Создать пост
POST 'set_post', to: 'posts#set_post'
http://localhost:3000/set_post
params { title: "title", content: "content", user_login: 'login_n' }
uri = URI.parse("http://localhost:3000/set_post")
params = { 'title' => "post_#{i}", 'content' => "content", 'user_login' => "login_#{rand(1..100)}", "ip" => "192.168.0.#{rand(1..49)}" }
Net::HTTP.post_form(uri, params)


# Поставить оценку посту
POST 'set_rating', to: 'posts#set_rating'
http://localhost:3000/set_rating
params { num: 1, post_id: 5 }
uri = URI.parse("http://localhost:3000/set_rating")
parmas = { 'num' => 5, 'post_id' => 5 }
Net::HTTP.post_form(uri, parmas)


# Получить топ N постов по среднему рейтингу.
GET 'posts_top', to: 'posts#posts_top'
http://localhost:3000/posts_top?n=6
params { n: N }
> curl http://localhost:3000/get_top_posts/101



# Получить список айпи, с которых постило несколько разных авторов.
GET 'get_lists_ip', to: 'posts#get_lists_ip'
http://localhost:3000/get_lists_ip
params {}
> curl http://localhost:3000/get_lists_ip


psql -l
psql -d dbname
DROP TABLE social_networks;

