class ArticlesController < ApplicationController

  before_action :require_login, only: [:new, :edit, :create]

  def require_login
    unless current_user
      flash[:error] = "you must login dude"
      redirect_to sign_in_path
    end
  end

  def index
    #if params[:action].eql?('index')
     # redirect_to article_path(27)
    #end
    if params[:status].eql?('active')
      @articles = Article.where(status: 'true')
    elsif params[:status].eql?('inactive')
      @articles = Article.where(status: 'false')
    else
      @articles = Article.all
    end 
    #@articles = Article.order('created_at DESC')
    #if params[:status].eql? 'active'
    #  @articles = Article.first
   # end
    #@article = Article.find_by_id(params[:id])
  end

  def status
    
  end
  
 def new
   @article = Article.new(title: cookies[:name])
 end

 def show
   if current_user
     @article = Article.find_by_id(params[:id])
   else
     flash[:notice] = "you not login"
     redirect_to root_url
   end
 end

 def create
   @article = Article.new(param_articles)
   if @article.save
     flash[:success] = t('forms.messages.success')
     cookies[:name] = "reyza"
     redirect_to root_path
   else
     render 'new'
   end
 end
 
 def edit
   @article = Article.find_by_id(params[:id])
 end
 
 def update
   @article = Article.find_by_id(params[:id])
     if @article.update_attributes(param_articles)
       flash[:success] = t('forms.messages.success')
       redirect_to articles_path
     else
       render 'edit'
     end
 end

 def destroy
   @article = Article.find_by_id(params[:id])
   @article.destroy
   redirect_to root_url
 end 

 def import
   Thread.new do 
    `RAILS_ENV=development bin/delayed_job restart`
   end
   Article.delay.import(params[:file])
   redirect_to articles_progress_status_path
 end

 def progress
   @article = Article.all
   render json: { id: @doc.id }
 end

 private
 def param_articles
   params.require(:article).permit(:title, :body, :status)
 end
end
