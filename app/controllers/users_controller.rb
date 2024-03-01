class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: "ユーザー情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end
end
