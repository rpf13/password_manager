class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [:index, :new, :create]

  def index
    @passwords = current_user.passwords
  end

  def show
    # no code required since we have the before_action :set_password
  end

  def new
    @password = Password.new
  end

  def create
    # an alternative way of creatign the password would be the following
    # but as soon as we did introduce the role parameter, we did change
    # back to the other code
    # the way the commented code is doing it is to let rails to the magic and create the
    # join action through automatically
    # @password = current_user.passwords.create(password_params)
    # if @password.persisted?
    #   redirect_to @password
    # else
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user, role: :owner)
    if @password.save
      redirect_to @password
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # no code required since we have the before_action :set_password
  end

  def update
    if @password.update(password_params)
      redirect_to @password
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy
    redirect_to root_path
  end
end

private

def password_params
  params.require(:password).permit(:url, :username, :password)
end

def set_password
  @password = current_user.passwords.find(params[:id])
end