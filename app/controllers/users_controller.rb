

class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@rooms = @user.rooms
  end

  skip_before_filter :require_no_authentication, only: [:create]

  def edit
  	redirect_to root_path unless current_user.is_admin?
  	@user = User.find(params[:id])
  end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User Deleted"
  	redirect_to admin_panel_users_url
  end

  def create
    redirect_to root_path unless current_user.is_admin?
    @user = User.create!(:fullname => "Ex. John Doe", :email => "levart_new_user@gmail.com", :password => "test1234")
    redirect_to "/admin_edit_new"
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created User"
    end
  end

  def logged_in_user
  	unless logged_in?
  		flash[:danger] = "Please Log in"
  		redirect_to root_path
  	end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to admin_panel_users_path
    else
      render 'edit'
    end
  end

  def correct_user
  	@user = User.find(params[:id])
  	redirect_to root_path unless @user == current_user
  end

  private
    def user_params
      params.permit(:fullname, :email, :phone_number, :description, :password)
    end
  
end  
