class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login_based_on_url
  before_filter :set_is_admin_path

  helper_method :is_admin?
  def is_admin?
    !self.current_staff_member.nil?
  end

  helper_method :is_admin_view?
  def is_admin_view?
    self.is_admin? && !params[:is_admin].nil?
  end

  def current_staff_member
    @current_staff_member ||= StaffMember.find(session[:staff_member_id]) if session[:staff_member_id]
  end

  private

  def set_is_admin_path
    self.default_url_options[:is_admin] = self.is_admin_view? ? "admin" : nil
  end

  def require_login_based_on_url
    if !params[:is_admin].nil? && current_staff_member.nil?
      redirect_to "/sessions/new"
    end
  end

  helper_method :current_staff_member
end
