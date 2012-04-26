class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.paginate(:page => params[:page], :per_page => 5).order('coalesce(date_received, created_at) DESC')
    @badge = "all"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @requests }
    end
  end

  # GET /requests/overdue
  def overdue
    @requests = Request.paginate(:page => params[:page], :per_page => 5).overdue
    @badge = "overdue"

    respond_to do |format|
      format.html { render :action => "index" }
      format.json { render :json => @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @request }
    end
  end
  
  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new
    @states = State.all()
    @request.requestor = Requestor.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @requestor_editable = false
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    request = params[:request]
    requestor = request.delete :requestor_attributes
    @request = Request.new(request)
    
    if requestor[:id].nil?
      @request.requestor = Requestor.new(requestor)
    else
      @request.requestor = Requestor.find(requestor[:id])
    end

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, :notice => 'Request was successfully created.' }
        format.json { render :json => @request, :status => :created, :location => @request }
      else
        format.html { render :action => "new" }
        format.json { render :json => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, :notice => 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end
  
  # GET /requests/1/new_response
  def new_response
    @request = Request.find(params[:id])
    @response = Response.new
    @response.request = @request
  end
end
