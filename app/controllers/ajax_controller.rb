class AjaxController < ApplicationController
  def requestors
    if params[:term]
      requestors = Requestor.where("name like '%'||?||'%'", params[:term])
    else
      requestors = Requestor.all
    end
    list = requestors.map {|u| {:id => u.id, :label => u.name, :name => u.name}}
    render :json => list
  end
end
