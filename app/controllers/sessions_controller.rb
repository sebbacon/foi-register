class SessionsController < ApplicationController
  def initialize(*params)
    super(*params)
    @does_not_require_login = true
  end
  
  def new
  end
  
  def create
    staff_member = StaffMember.find_by_email(params[:email])
    if staff_member && staff_member.authenticate(params[:password])
      session[:staff_member_id] = staff_member.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def logout
    session[:staff_member_id] = nil
    redirect_to "/requests", :notice => "Logged out"
  end
end
