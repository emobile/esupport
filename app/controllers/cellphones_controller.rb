class CellphonesController < ApplicationController
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
    @cellphones = current_user.role.super_admin == true ? Cellphone.order("id DESC").paginate(:page => params[:page]) : Cellphone.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_cellphones = current_user.role.super_admin == true ? Cellphone.all : Cellphone.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_cellphones }
        format.csv { render text: @all_cellphones.to_csv }
        format.xls { send_data @all_cellphones.to_csv(col_sep: "\t") }
      else
        format.json { render json: @cellphones }
        format.csv { render text: @cellphones.to_csv }
        format.xls { send_data @cellphones.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /cellphones/1
  # GET /cellphones/1.json
  def show
    @cellphone = Cellphone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cellphone }
    end
  end

  # GET /cellphones/new
  # GET /cellphones/new.json
  def new
    @cellphone = Cellphone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cellphone }
    end
  end

  # GET /cellphones/1/edit
  def edit
    @cellphone = Cellphone.find(params[:id])
  end

  # POST /cellphones
  # POST /cellphones.json
  def create
    @cellphone = Cellphone.new(params[:cellphone])

    respond_to do |format|
      if @cellphone.save
        format.html { redirect_to @cellphone, notice: 'Cellphone was successfully created.' }
        format.json { render json: @cellphone, status: :created, location: @cellphone }
      else
        format.html { render action: "new" }
        format.json { render json: @cellphone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cellphones/1
  # PUT /cellphones/1.json
  def update
    @cellphone = Cellphone.find(params[:id])

    respond_to do |format|
      if @cellphone.update_attributes(params[:cellphone])
        format.html { redirect_to @cellphone, notice: 'Cellphone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cellphone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cellphones/1
  # DELETE /cellphones/1.json
  def destroy
    @cellphone = Cellphone.find(params[:id])
    @cellphone.destroy

    respond_to do |format|
      format.html { redirect_to cellphones_url }
      format.json { head :no_content }
    end
  end

end
