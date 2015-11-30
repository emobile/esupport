class ComputersController < ApplicationController
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
    @computers = current_user.role.super_admin == true ? Computer.order("id DESC").paginate(:page => params[:page]) : Computer.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_computers = current_user.role.super_admin == true ? Computer.all : Computer.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_computers }
        format.csv { render text: @all_computers.to_csv }
        format.xls { send_data @all_computers.to_csv(col_sep: "\t") }
      else
        format.json { render json: @computers }
        format.csv { render text: @computers.to_csv }
        format.xls { send_data @computers.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
    @computer = Computer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @computer }
    end
  end

  # GET /computers/new
  # GET /computers/new.json
  def new
    @computer = Computer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @computer }
    end
  end

  # GET /computers/1/edit
  def edit
    @computer = Computer.find(params[:id])
  end

  # POST /computers
  # POST /computers.json
  def create
    @computer = Computer.new(params[:computer])

    respond_to do |format|
      if @computer.save
        format.html { redirect_to @computer, notice: 'Computer was successfully created.' }
        format.json { render json: @computer, status: :created, location: @computer }
      else
        format.html { render action: "new" }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /computers/1
  # PUT /computers/1.json
  def update
    @computer = Computer.find(params[:id])

    respond_to do |format|
      if @computer.update_attributes(params[:computer])
        format.html { redirect_to @computer, notice: 'Computer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer = Computer.find(params[:id])
    @computer.destroy

    respond_to do |format|
      format.html { redirect_to computers_url }
      format.json { head :no_content }
    end
  end
end
