class SessionsController < ApplicationController
  skip_before_filter :require_login
  
  def new
  end
  
  def create
    staff_member = StaffMember.find_by_email(params[:email])
    if staff_member && staff_member.authenticate(params[:password])
      session[:staff_member_id] = staff_member.id
      redirect_to "/admin/requests", :notice => "Logged in"
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
