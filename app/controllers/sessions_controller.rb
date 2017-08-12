class SessionsController < ApplicationController
  def logout
    sign_out
    flash.now[:info] = "Você deslogou com sucesso."
    redirect_to root_path
  end

  def login
    if user = User.where(user_params).first
      sign_in(user)
      flash[:info] = "Logado com sucesso."
    else
      flash[:error] = "Credenciais desconhecidas."
    end

    redirect_to root_path
  end

  def new
  end

  private

  def user_params
    params.require(:session).permit(:name, :password)
  end
end

