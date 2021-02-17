class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_action :set_article, only: [:show, :edit, :update, :destroy, :flip_like]
  before_action :add_view, only: [:show]
  before_action :set_view, only: [:flip_like, :show]
  # GET /articles
  # GET /articles.json
  def index
    #to show popular articles
    @popular_articles=Article.order(views: :DESC).limit(3)
    #unregistered users can only read 5 articles
    if session[:user_id] && !session[:private_articles_left]
      session[:private_articles_left]=current_user.private_articles_left
    end
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show  
    #to keep count of private articles read
    if session[:private_articles_left] == 0 && !@article.public
      redirect_to root_url, alert: "Private Article limit reached"
    elsif session[:user_id] && !@article.public && !current_user.admin
      session[:private_articles_left]-=1
      flash[:alert]="Private articles left:"+ session[:private_articles_left].to_s
      current_user.update( private_articles_left: session[:private_articles_left])
    end
    @likes = View.where( liked: true, article_id: @article.id ).count
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "article",
        page_size: 'A4',
        template: "articles/show.html.erb",
        layout: "pdf.html",
        orientation: "Portrait"
      end
     end

  end

  #when session[:private_articles_left]
  def limit

  end
  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = session[:user_id]


    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def flip_like
    #to like and unlike an article
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Invalid path' }
      if @view.update( liked: !@view.liked )
        @likes = View.where( liked: true, article_id: @article.id ).count
        format.js
      else
        format.js render json: { status: "err" }.to_json
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :topic, :tags, :content, :public, :image)
    end
    
    #to add views
    def add_view
      if current_user
        if !View.exists?(user_id: current_user.id, article_id: @article.id)
          View.new(user_id: current_user.id, article_id: @article.id).save
          #increase views
          @article.update(views: @article.views+1)
        end
      end
    end

    def set_view
      if current_user
        @view = View.find_by("user_id = ? AND article_id = ? ", current_user.id, @article.id )
      else
        @view = nil
      end
    end
end
