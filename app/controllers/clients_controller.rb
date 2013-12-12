require 'securerandom'
class ClientsController < ApplicationController
  before_filter :authenticate_access!, :except => [:new, :create]
  before_filter :check_client, :only => [:edit, :update, :show, :destroy]  
  load_and_authorize_resource

  def authenticate_access!
    if client_session.blank?
      authenticate_user!
    else
      authenticate_client!
    end
  end
  
  def check_client
    unless @is_user
      unless params[:id] == current_client.id
        flash[:error] = t"not_authorized"
        redirect_to root_path
      end
    end
  end
  
  def index
    @clients = Client.paginate(:page => params[:page]).order("id DESC")
    @all_clients = Client.order("id DESC")
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_clients }
        format.csv { render text: @all_clients.to_csv }
        format.xls { send_data @all_clients.to_csv(col_sep: "\t") }
      else
        format.json { render json: @clients }
        format.csv { render text: @clients.to_csv }
        format.xls { send_data @clients.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      if params[:callback]
        format.json { render :json => @client, :callback => params[:callback] }     
      else
        format.json { render json: @client }
      end
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
    @client.bills.build
    @role = Role.where(:client => true).first
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])
    #    @client.username = SecureRandom.hex(4) 
    #    @client.password = SecureRandom.hex(4)
    #    @client.password_confirmation =  @client.password
    respond_to do |format|
      if @client.save
        #ClientMailer.new_client_registration(@client)
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        #format.html { render action: "/clients/new" }
        redirect_to new_client_path
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
  
end
