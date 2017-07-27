class SessionsController < ApplicationController
  before_action :is_logged, only: [:new, :create]

  # Responsável pela página de login
  def new
  end

  # Cria uma nova sessão
  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to user
    else
      respond_to do |format|
        format.html { redirect_to request.referrer, alert: 'Something went wrong!' }
      end
    end
  end

  # Destrói uma sessão
  def destroy
    log_out
    redirect_to root_url
  end

  private

    # Parâmetros enviados pelas requisições que serão aceitos
    def session_params
      params.require(:session).permit(:email, :password)
    end

    # Se já houver um usuário logado, redireciona para a página de usuários
    def is_logged
      respond_to do |format|
        format.html { redirect_to current_user }
      end if logged_in?
    end
end
