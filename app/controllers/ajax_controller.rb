class AjaxController < ApplicationController
  def requestors
    if params[:term]
      requestors = Requestor.where("name like '%'||?||'%'", params[:term])
    else
      requestors = Requestor.all
    end
    list = requestors.map {|requestor| {
      :id => requestor.id, :label => requestor.name,
      :name => requestor.name, :email => requestor.email, :notes => requestor.notes
    }}
    render :json => list
  end
end
