class RedirectionController < ApplicationController
  
  # The front page: redirect to the register list
  def front
    redirect_to :controller => 'requests', :action => 'index', :status => :moved_permanently
  end
end
