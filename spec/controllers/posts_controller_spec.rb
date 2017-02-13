require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  # Создать пост.
  # #=> {Post}
  # #=> {error}
  # POST /set_post
  describe 'POST #set_post' do
    context 'Insert new Post' do
      it 'Return 200 status' do
        post :set_post, params: { 'title' => "post_i", 'content' => "content", 'user_login' => "login_1", "ip" => "192.168.0.1" }

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['content']).to include('content')
      end

      it 'return 422 status' do
        post :set_post, params: { 'title' => "", 'content' => "content", 'user_login' => "login_#{rand(1..100)}", "ip" => "192.168.0.#{rand(1..49)}" }

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(422)
      end
    end
  end


  # Поставить оценку посту
  # #=> {rating: n} - average rating post
  # #=> {error}
  # POST /set_rating
  describe 'POST #set_rating' do
    let(:post1) { create(:post) }

    context 'Insert Rating' do
      it 'Return average rating' do
        post :set_rating, params: { 'num' => 5, 'post_id' => 1 }

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['rating']).to eq '5.0'
      end
    end
  end


  # Получить топ N постов по среднему рейтингу.
  # #=> [{title: 'title', content: 'content'}]
  # GET /get_top_posts
  describe 'GET #get_top_posts' do
    context 'Get top 10 of posts' do
      it 'Return top posts' do
        get :get_top_posts, params: { 'n' => 10 }

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.count).to eq 10
      end
    end
  end



  # Получить список айпи, с которых постило несколько разных авторов.
  # #=> [{ip: ip, users: ['login_1', 'login_2', ...]}, {}, ...]
  # GET /get_lists_ip
  describe 'GET #get_lists_ip' do
    describe 'Get lists ips' do
      it 'Return ips lists' do
        get :get_lists_ip

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body[0]['users'].count).to be >= 1
      end
    end
  end
end
