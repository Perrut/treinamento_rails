# Posts Controller
class PostsController < ApplicationController
  before_action :logged_user
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :correct_or_admin_user, only: :destroy

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html do
          redirect_to @post,
                      notice: 'Post atualizado com sucesso.'
        end
      else
        format.html { render :edit, notice: 'Algo deu errado.' }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html do
        redirect_to posts_url,
                    notice: 'Post destruido com sucesso.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def post_params
    params.require(:post).permit(:content, :user_id)
  end

  # Conferir se o usuario e o dono do Post
  def correct_user
    respond_to do |format|
      if current_user.id != @post.user_id
        format.html { redirect_to posts_url, alert: 'Não permitido!' }
      end
    end
  end

  # Conferir se o usuario e administrador ou dono do post
  def correct_or_admin_user
    respond_to do |format|
      if current_user != @post.user && current_user.admin == false
        format.html { redirect_to posts_url, alert: 'Não permitido!' }
      end
    end
  end
end
