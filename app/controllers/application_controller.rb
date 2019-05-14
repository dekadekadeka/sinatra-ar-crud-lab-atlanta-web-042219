
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get "/articles/new" do
    erb :new
  end

  post "/articles" do
    @title = params["title"]
    @content = params["content"]
    art = Article.create(params)
    redirect "/articles/#{art.id}"
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @title = params.fetch("title")
    @content = params.fetch("content")
    id = params.fetch("id").to_i
    @article = Article.find(id)
    @article.update({"title" => @title, "content" => @content})
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect "/articles"
  end

end
