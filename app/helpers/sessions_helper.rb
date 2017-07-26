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

  #Encerra a sessão do usuário
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
end
