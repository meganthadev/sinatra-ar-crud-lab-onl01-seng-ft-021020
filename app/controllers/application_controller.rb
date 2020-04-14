require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles' do 
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do 
    @article = Article.new
    erb :new
  end

  post '/articles' do
    
    @article = Article.create(params[:article])
    redirect "/articles/#{@article.id}"
  end


  get '/articles/:id' do 
    # binding.pry
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end

  delete '/articles/:id' do
    Article.find(params[:id]).destroy
    redirect '/articles'
  end

end