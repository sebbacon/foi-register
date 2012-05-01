class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  before_filter :set_is_admin_path

  helper_method :is_admin?
  def is_admin?
    !@current_staff_member.nil?
  end

  private

  def set_is_admin_path
    self.default_url_options[:is_admin] = self.is_admin? ? "admin" : nil
  end

  def current_staff_member
    @current_staff_member ||= StaffMember.find(session[:staff_member_id]) if session[:staff_member_id]
  end

  def require_login
    logger.info "#{self.class} has @does_not_require_login = #{@does_not_require_login}"
    if (!@does_not_require_login || !params[:is_admin].nil?) && current_staff_member.nil?
      redirect_to "/sessions/new"
    end
  end

  helper_method :current_staff_member
end
