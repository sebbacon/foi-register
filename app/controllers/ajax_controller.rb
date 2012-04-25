class AjaxController < ApplicationController
  def requestors
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      requestors = Requestor.where("name like ?", like)
    else
      requestors = Requestor.all
    end
    list = requestors.map {|u| {:id => u.id, :label => u.name, :name => u.name}}
    render :json => list
  end
end
