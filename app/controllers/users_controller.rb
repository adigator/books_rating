class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to '/signup'
    end
  end

  def show
    redirect_to root_path unless current_user && ( current_user.id == @user.id || current_user.admin? )
  end

  def edit
    redirect_to root_path unless current_user && ( current_user.id == @user.id || current_user.admin? )
  end



  def update

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'Użytkownik poprawiony.' }

      else
        format.html { render :edit }

      end
    end
  end


  def destroy

    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Użytkownik usuniety.' }
      format.json { head :no_content }
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username,:email, :password, :role)
  end
end
