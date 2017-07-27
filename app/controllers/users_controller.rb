class UsersController < ApplicationController
  before_action :logged_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :non_logged_user, only: [:new, :create]
  before_action :correct_or_admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user == @user
      log_out
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
    end

    # Verificar se o usuário que está logado é o mesmo da referida página
    def correct_user
      respond_to do |format|
        format.html { redirect_to users_url, alert: 'Não permitido!' }
      end if current_user != @user
    end

    # Verificar se o usuário logado é correspondente ao perfil ou é administrador
    def correct_or_admin_user
      if current_user != @user && current_user.admin == false
        respond_to do |format|
          format.html { redirect_to users_url, alert: 'Não permitido!' }
        end
      end
    end

    # Se alguém logado tentar criar um novo usuário, redirecionar
    def non_logged_user
      respond_to do |format|
        format.html { redirect_to users_url, alert: 'Não permitido!' }
      end if current_user != nil
    end
end
