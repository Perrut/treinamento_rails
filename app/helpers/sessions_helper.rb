module SessionsHelper

  #Logar o usuário
  def log_in(user)
    session[:user_id] = user.id
  end

  #Retornar o usuário que está logado
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Descobrir se um usuário está logado
  def logged_in?
    !current_user.nil?
  end

  #Descobrir se um usuário está logado e redirecionar caso não esteja
  def logged_user
    respond_to do |format|
      format.html { redirect_to root_url, alert: 'Por favor faça login.' }
    end if !logged_in?
  end

  #Encerra a sessão do usuário
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
