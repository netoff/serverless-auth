class Api::UsersController < ApplicationController
  def create
    user = User.create!(user_params)

    render status: 201, json: {
      email: user.email,
      token: user.jwt_token
    }
  rescue ActiveRecord::RecordInvalid => e
    render status: 400, plain: e.record.errors.full_messages.join('')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
