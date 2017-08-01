# Sessions
class SessionsController < ApplicationController
  before_action :is_logged, only: %i[new create]

  # Responsavel pela pagina de login
  def new; end

  # Cria uma nova sessao
  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      log_in user
      return
    end
    respond_to do |format|
      format.html do
        redirect_to request.referrer, alert: 'Something went wrong!'
      end
    end
  end

  # Destroi uma sessao
  def destroy
    log_out
    redirect_to root_url
  end

  private

  # Parametros enviados pelas requisicoes que serao aceitos
  def session_params
    params.require(:session).permit(:email, :password)
  end

  # Se ja houver um usuario logado, redireciona para a pagina de usuarios
  def is_logged
    respond_to do |format|
      format.html { redirect_to current_user }
    end if logged_in?
  end
end
