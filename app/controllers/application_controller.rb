class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def current_staff_member
    @current_staff_member ||= StaffMember.find(session[:staff_member_id]) if session[:staff_member_id]
  end

  private
  def require_login
    logger.info "#{self.class} has @does_not_require_login = #{@does_not_require_login}"
    if !@does_not_require_login && current_staff_member.nil?
      redirect_to "/sessions/new"
    end
  end

  helper_method :staff_member
end
