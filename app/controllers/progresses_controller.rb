class ProgressesController < ApplicationController
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
    @progresses = current_user.role.super_admin == true ? Progress.order("id DESC").paginate(:page => params[:page]) : Progress.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_progresses = current_user.role.super_admin == true ? Progress.all : Progress.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_progresses }
        format.csv { render text: @all_progresses.to_csv }
        format.xls { send_data @all_progresses.to_csv(col_sep: "\t") }
      else
        format.json { render json: @progresses }
        format.csv { render text: @progresses.to_csv }
        format.xls { send_data @progresses.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /progresses/1
  # GET /progresses/1.json
  def show
    @progress = Progress.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @progress }
    end
  end

  # GET /progresses/new
  # GET /progresses/new.json
  def new
    @progress = Progress.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @progress }
    end
  end

  # GET /progresses/1/edit
  def edit
    @progress = Progress.find(params[:id])
  end

  # POST /progresses
  # POST /progresses.json
  def create
    @progress = Progress.new(params[:progress])
    unless params[:progress][:order_id].blank?
      @order = Order.find(params[:progress][:order_id])
      #@progress.branch_id = @order.branch_id
    end

    respond_to do |format|
      if @progress.save
        format.html { redirect_to @progress.order, notice: 'Progress was successfully created.' }
        format.json { render json: @progress, status: :created, location: @progress }
      else
        format.html { render action: "new" }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /progresses/1
  # PUT /progresses/1.json
  def update
    @progress = Progress.find(params[:id])

    respond_to do |format|
      if @progress.update_attributes(params[:progress])
        format.html { redirect_to @progress.order, notice: 'Progress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progresses/1
  # DELETE /progresses/1.json
  def destroy
    @progress = Progress.find(params[:id])
    @progress.destroy

    respond_to do |format|
      format.html { redirect_to progresses_url }
      format.json { head :no_content }
    end
  end
end
