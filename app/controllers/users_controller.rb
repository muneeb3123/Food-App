class UsersController < ApplicationController
  # before_action :authenticate_user!, only:[:show]
  def index; end

  def show; end

  def create
    user = User.new(user_params)
    flash[:notice] = if user.save
                       'User successfully created'
                     else
                       'User not created'
                     end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end
end
