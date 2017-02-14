class PostsController < InheritedResources::Base
  def index
    @posts = Post.page params[:page]
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find params[:id]
  end


  # Создать пост.
  # #=> {Post}
  # #=> {error}
  # POST /set_post
  def set_post
    title   = params[:title]
    content = params[:content]
    login   = params[:user_login]
    ip      = params[:ip]

    # Возвращает ошибки валидации со статусом 422.
    if title.empty? or content.empty?
      msg = 'Заголовок и содержание поста не могут быть пустыми!'
      render json: { error: msg }, status: 422
      return
    end

    # Find or create ip
    ip = Ip.find_or_create_by(ip: ip || request.remote_ip)

    # Find or create user
    user = User.find_or_create_by(login: login) { |u| u.ip_id = ip.id }

    # Create new post
    post = Post.create(
      title:   title,
      content: content,
      user_id: user.id,
      ip_id:   ip.id)

    # Возвращает атрибуты поста со статусом 200
    render json: post
  end


  # Поставить оценку посту
  # #=> {rating: n} - average rating post
  # #=> {error}
  # POST /set_rating
  def set_rating
    # Важно: экшен должен корректно отрабатывать
    # при любом количестве конкурентных запросов
    # на оценку одного и того же поста.
    post_id = params[:post_id]
    num     = params[:num]

    Rating.create(num: num, post_id: post_id)

    rating = Rating.rating post_id

    render json: { rating: rating }
  end


  # Получить топ N постов по среднему рейтингу.
  # #=> [{title: 'title', content: 'content'}]
  # GET /get_top_posts
  def get_top_posts
    n = params[:n] || 10

    posts = Post.top_posts.limit n 

    render json: posts
  end


  # Получить список айпи, с которых постило несколько разных авторов.
  # #=> [{ip: ip, users: ['login_1', 'login_2', ...]}, {}, ...]
  # GET /get_lists_ip
  def get_lists_ip
    ips = Ip.lists_ip

    render json: ips.compact
  end
end
