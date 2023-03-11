class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id})
      render json: { user: @user, token: token }, status: 200 
    else
      render json: { error: "Invalid!!!" }, status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :password, :email)
  end
end