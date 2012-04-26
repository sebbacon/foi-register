class AjaxController < ApplicationController
  def requestors
    if params[:term]
      requestors = Requestor.where("name like '%'||?||'%'", params[:term])
    else
      requestors = Requestor.all
    end
    list = requestors.map {|requestor| {
      :id => requestor.id, :label => requestor.to_s, :value => requestor.name,
      :name => requestor.name, :email => requestor.email
    }}
    render :json => list
  end
end
