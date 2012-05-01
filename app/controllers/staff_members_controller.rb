class StaffMembersController < ApplicationController
  http_basic_authenticate_with :name => "admin", :password => "BYEAjfCVCiyF"
  
  def initialize(*params)
    super(*params)
    @does_not_require_login = true
  end
  
  def new
    @staff_member = StaffMember.new
  end
  
  def create
    @staff_member = StaffMember.new(params[:staff_member])
    if @staff_member.save
      redirect_to "/requests", :notice => "Created new staff member <#{@staff_member.email}>"
    else
      render "new"
    end
  end
  
  def index
    @staff_members = StaffMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @staff_members }
    end
  end
end
