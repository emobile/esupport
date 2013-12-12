class ClientNeedsController < ApplicationController
  before_filter :authenticate_access!
  load_and_authorize_resource

  def authenticate_access!
    if client_session.blank?
      authenticate_user!
    else
      authenticate_client!
    end
  end
  
  def index
    @client_needs = current_user.role.super_admin == true ? ClientNeed.order("id DESC").paginate(:page => params[:page]) : ClientNeed.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_client_needs = current_user.role.super_admin == true ? ClientNeed.all : ClientNeed.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_client_needs }
        format.csv { render text: @all_client_needs.to_csv }
        format.xls { send_data @all_client_needs.to_csv(col_sep: "\t") }
      else
        format.json { render json: @client_needs }
        format.csv { render text: @client_needs.to_csv }
        format.xls { send_data @client_needs.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /client_needs/1
  # GET /client_needs/1.json
  def show
    @client_need = ClientNeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_need }
    end
  end

  # GET /client_needs/new
  # GET /client_needs/new.json
  def new
    @client_need = ClientNeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_need }
    end
  end

  # GET /client_needs/1/edit
  def edit
    @client_need = ClientNeed.find(params[:id])
  end

  # POST /client_needs
  # POST /client_needs.json
  def create
    @client_need = ClientNeed.new(params[:client_need])

    respond_to do |format|
      if @client_need.save
        format.html { redirect_to @client_need, notice: 'Client need was successfully created.' }
        format.json { render json: @client_need, status: :created, location: @client_need }
      else
        format.html { render action: "new" }
        format.json { render json: @client_need.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_needs/1
  # PUT /client_needs/1.json
  def update
    @client_need = ClientNeed.find(params[:id])

    respond_to do |format|
      if @client_need.update_attributes(params[:client_need])
        format.html { redirect_to @client_need, notice: 'Client need was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_need.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_needs/1
  # DELETE /client_needs/1.json
  def destroy
    @client_need = ClientNeed.find(params[:id])
    @client_need.destroy

    respond_to do |format|
      format.html { redirect_to client_needs_url }
      format.json { head :no_content }
    end
  end
end
