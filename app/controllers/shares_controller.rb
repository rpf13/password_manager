class SharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password
  before_action :require_editable_permission

  def new
    # The current_user is excluded from the dropdown list, and once a password
    # is shared with another user, that user is also excluded. This has been
    # moved to the /shares/new.html.erb to have it for the new
    # and the create action in one place
    # @users = User.excluding(@password.users)
    @user_password = UserPassword.new
  end

  def create
    @user_password = @password.user_passwords.new(user_password_params)
    if @user_password.save
      redirect_to @password
    else
      # see comment under new action
      # @users = User.excluding(@password.users)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @password.user_passwords.where(user_id: params[:id]).destroy_all
    redirect_to @password
  end

  private

  def set_password
    @password = current_user.passwords.find(params[:password_id])
  end

  def user_password_params
    params.require(:user_password).permit(:user_id, :role)
  end

  def require_editable_permission
    redirect_to @password unless current_user_password.editable?
  end

  def require_shareable_permission
    redirect_to @password unless current_user_password.shareable?
  end
end

