class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:name])
    return head(:forbidden) unless @user.authenticate(params[:password])
    session[:user_id] = @user.id
  end

  def destroy
    session.delete :name
  end

  private
  def sessions_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end