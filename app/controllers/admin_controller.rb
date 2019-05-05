class AdminController < ApplicationController
  before_action :authenticate_user!

  def admin_panel
  	redirect_to root_path unless current_user.is_admin?
  	@users = User.all
    @reservations = Reservation.all
  end

  def admin_panel_users
  	redirect_to root_path unless current_user.is_admin?
    @users = User.all
  end

  def admin_panel_bookings
  	redirect_to root_path unless current_user.is_admin? 
  	@reservations = Reservation.all
  end

  #Defines Booking search
  def bookings_search
    redirect_to root_path unless current_user.is_admin?

    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    arrResult = Array.new

    @search = Reservation.ransack(params[:q])
    @reservations = @search.result

    @arrResult = @reservations.to_a

    if (params[:id] && !params[:id].empty?)

      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @reservation.each do |reservation|

        available = room.reservations.where(
            "(? == reservation.id)",
            reservation.id
          ).limit(1)

      end    

    end

  end


  def users_search
    redirect_to root_path unless current_user.is_admin?

    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    arrResult = Array.new

    @search = User.ransack(params[:q])
    @users = @search.result

    @arrResult = @users.to_a

    if (params[:fullname] && !params[:fullname].empty?)
      

      @users.each do |user|

        available = @users.where(
            "(? == fullname)",
            fullname
          ).limit(2)
      end

    end
    
  end

  def create
    @user = User.create!(:fullname => "Ex. John Doe", :email => "levart_new_user@gmail.com", :password => "test1234")
    redirect_to edit_user_path(@user)
  end

 #Defines Problem Tickets
  def problem_tickets
    redirect_to root_path unless current_user.is_admin?
    @conversations = Conversation.all
  end

end



