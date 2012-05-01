class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  before_filter :set_is_admin_path

  def is_admin?
    true
  end
  helper_method :is_admin?

  private
  def set_is_admin_path
    self.default_url_options[:is_admin] = self.is_admin? ? "admin" : nil
  end

  def authenticate
    if params[:is_admin] == "admin"
      # do something here
    end
  end
end
