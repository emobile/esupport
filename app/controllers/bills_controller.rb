class BillsController < ApplicationController
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
    #@bills = current_user.role.super_admin == true ? Bill.order("id DESC").paginate(:page => params[:page]) : Bill.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    #@all_bills = current_user.role.super_admin == true ? Bill.all : Bill.where(:branch_id => current_user.branch_id)
    if @is_user
      @bills = Bill.order("id DESC").paginate(:page => params[:page])
      @all_bills = Bill.order("id DESC")
    else
      @bills = Bill.where(:client_id => current_client.id).paginate(:page => params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_bills }
        format.csv { render text: @all_bills.to_csv }
        format.xls { send_data @all_bills.to_csv(col_sep: "\t") }
      else
        format.json { render json: @bills }
        format.csv { render text: @bills.to_csv }
        format.xls { send_data @bills.to_csv(col_sep: "\t") }
      end
    end
  end

  def get_bill_by_client_id
    @bill = Bill.find_by_client_id(params[:client_id])

    respond_to do |format|
      format.html # show.html.erb
      if params[:callback]
        format.json { render :json => @bill, :callback => params[:callback] }
      else
        format.json { render json: @bill }
      end
    end
  end
  # GET /bills/1
  # GET /bills/1.json
  def show
    if params[:autocomplete] == true
      @bill = Bill.find_by_client_id(params[:id])
    else
      @bill = Bill.find(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      if params[:callback]
        format.json { render :json => @bill, :callback => params[:callback] }     
      else
        format.json { render json: @bill }
      end
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render json: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.json
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :no_content }
    end
  end
end
