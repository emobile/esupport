class WorkshopsController < ApplicationController
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
    @workshops = current_user.role.super_admin == true ? Workshop.order("id DESC").paginate(:page => params[:page]) : Workshop.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_workshops = current_user.role.super_admin == true ? Workshop.all : Workshop.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_workshops }
        format.csv { render text: @all_workshops.to_csv }
        format.xls { send_data @all_workshops.to_csv(col_sep: "\t") }
      else
        format.json { render json: @workshops }
        format.csv { render text: @workshops.to_csv }
        format.xls { send_data @workshops.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/new
  # GET /workshops/new.json
  def new
    @workshop = Workshop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
  end

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = Workshop.new(params[:workshop])

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: 'Workshop was successfully created.' }
        format.json { render json: @workshop, status: :created, location: @workshop }
      else
        format.html { render action: "new" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])

    respond_to do |format|
      if @workshop.update_attributes(params[:workshop])
        format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy

    respond_to do |format|
      format.html { redirect_to workshops_url }
      format.json { head :no_content }
    end
  end
end
