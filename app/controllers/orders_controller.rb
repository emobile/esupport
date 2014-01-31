class OrdersController < ApplicationController
  include OrdersHelper
  before_filter :authenticate_access!
  before_filter :check_client, :only => [:edit, :update, :show, :destroy]
  load_and_authorize_resource
  #  autocomplete :cellphone, :model, :extra_data => [:color, :imei, :ope_system, :model, :brand]
  #  autocomplete :client, :first_name, :extra_data => [:last_name]
  #  #autocomplete :part, :name
  autocomplete :brand, :name
  
  def authenticate_access!
    if client_session.blank?
      authenticate_user!
    else
      authenticate_client!
    end
  end
  
  def check_client
    unless @is_user
      @order = Order.find(params[:id])
      unless @order.client_id == current_client.id
        flash[:error] = t"not_authorized"
        redirect_to root_path
      end
    end
  end
  
  def index
    if @is_user
      @orders = current_user.role.super_admin == true ? Order.order("id DESC").paginate(:page => params[:page]) : Order.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
      @all_orders = current_user.role.super_admin == true ? Order.all : Order.where(:branch_id => current_user.branch_id)
    else
      @orders = Order.where(:client_id => current_client.id).order("id DESC").paginate(:page => params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_orders }
        format.csv { render text: @all_orders.to_csv }
        format.xls { send_data @all_orders.to_csv(col_sep: "\t") }
      else
        format.json { render json: @orders }
        format.csv { render text: @orders.to_csv }
        format.xls { send_data @orders.to_csv(col_sep: "\t") }
      end
    end
  end
  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @product = eval("Order#{@order.product_type.titlecase.singularize}.find_by_order_id(#{@order.id})")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @client = Client.find_by_id(@order.client_id)
    @bill = Bill.find_by_id((@order.bill_id))
    @render = "#{@order.product_type.downcase}_fields"
    @product = @order.product_type.downcase.pluralize
  end

  # POST /orders
  # POST /orders.json
  def create
    sns = params[:order][:serial_numbers_attributes] || {}
    params[:order].delete(:serial_numbers_attributes)
    @order = Order.new(params[:order])
    @order.editing = false
    @product = @order.product_type.downcase.pluralize
    respond_to do |format|
      if @order.save
        sns.each do |sn|
          OrderSerialNumbers.create(order_id: @order.id, serial_number_id: sn[:id])
        end
        total_due = 0
        @order.parts.each do |part|
          total_due = part.cost + total_due
        end
        @order.client_needs.each do |client_need|
          total_due = client_need.cost + total_due
        end
        @order.update_attribute(:total_due, total_due)
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    sns = params[:order][:serial_numbers_attributes] || {}
    @order.editing = true
    @client = Client.find_by_id(@order.client_id)
    @bill = Bill.find_by_id((@order.bill_id))
    @render = "#{@order.product_type.downcase}_fields"
    @product = @order.product_type.downcase.pluralize
    respond_to do |format|
      if @order.update_attributes(params[:order])
        sns.each do |sn|
          if sn[:_destroy] == "true"
            OrderSerialNumbers.find_by_order_id_and_serial_number_id(@order.id, sn[:id]).destroy
          else
            OrderSerialNumbers.create(order_id: @order.id, serial_number_id: sn[:id])
          end
        end
        total_due = 0
        @order.parts.each do |part|
          total_due = part.cost + total_due
        end
        @order.client_needs.each do |client_need|
          total_due = client_need.cost + total_due
        end
        @order.update_attribute(:total_due, total_due)
        Progress.create(:short_description => @order.short_description, :full_description => @order.full_description, :user_id => current_user.id, :order_id => @order.id, :branch_id => @order.branch_id)        
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  def cellphone
    @order = Order.new
    render :partial => 'cellphone_fields', :f => :builder
  end
  
  def computer
    render :partial => 'computer_fields', :type => :builder
  end

  def autocomplete_part_name
    parts = Part.where("UPPER(name) LIKE UPPER(?)  and branch_id = #{current_user.branch_id}", "%#{params[:term]}%")
    json = parts.collect do |part| 
      { "id" => part.id.to_s, 
        "label" => part.name + " ($ " + part.cost.to_s + ")", 
        "value" => part.name, 
        "description" => part.description, 
        "cost" => part.cost, 
      }
    end
    render json: json
  end
  
  def autocomplete_serial_number
    serial_numbers = SerialNumber.joins("INNER JOIN parts p ON serial_numbers.part_id = p.id").where("branch_id = ?", current_user.branch_id).select { |s| /#{params[:term]}/i =~ "(#{s.serial_number}) #{s.part.name}" }
    json = serial_numbers.collect do |serial_number| 
      { "id" => serial_number.id.to_s, 
        "value" => "(#{serial_number.serial_number}) #{serial_number.part.name}"
      }
    end
    render json: json
  end
  
  def autocomplete_client_need_name
    client_needs = ClientNeed.where("UPPER(name) LIKE UPPER(?)  and branch_id = #{current_user.branch_id}", "%#{params[:term]}%")
    json = client_needs.collect do |client_need| 
      { "id" => client_need.id.to_s, 
        "label" => client_need.name + " ($ " + client_need.cost.to_s + ")", 
        "value" => client_need.name, 
        "description" => client_need.description, 
        "cost" => client_need.cost
      }
    end
    render json: json
  end
  
  def autocomplete_client_first_name
    clients = Client.where("CONCAT(CONCAT(UPPER(clients.first_name), \' \'), UPPER(clients.last_name)) LIKE UPPER(?) OR CONCAT(CONCAT(UPPER(clients.last_name), \', \'), UPPER(clients.first_name)) LIKE UPPER(?)", "%#{params[:term].strip}%", "%#{params[:term].strip}%")
    json = clients.collect do |client| 
      { "id" => client.id.to_s, 
        "label" => client.first_name + " " + client.last_name + " (Id: " + client.id.to_s + ")", 
        "value" => client.first_name + " " + client.last_name,
        "first_name" => client.first_name,
        "last_name" => client.last_name,
      }
    end
    render json: json
  end
  
  def autocomplete_cellphone_model
    cellphones = Cellphone.where("(UPPER(model) LIKE UPPER(?) or UPPER(brand) LIKE UPPER(?) or UPPER(color) LIKE UPPER(?) or UPPER(ope_system) LIKE UPPER(?))and branch_id = #{current_user.branch_id}", "%#{params[:term].strip}%", "%#{params[:term].strip}%", "%#{params[:term].strip}%", "%#{params[:term].strip}%")
    json = cellphones.collect do |cellphone| 
      { "id" => cellphone.id.to_s, 
        "label" => cellphone.model + " (" + cellphone.brand + ",  " + cellphone.ope_system + ",  " + cellphone.color + ")", 
        "value" => cellphone.model,
        "ope_system" => cellphone.ope_system,
        "color" => cellphone.color,
        "model" => cellphone.model,
        "brand" => cellphone.brand
      }
    end
    render json: json, input_html: {update_elements: {}}
  end
  
  def autocomplete_computer_model
    computers = Computer.where("(UPPER(model) LIKE UPPER(?) or UPPER(brand) LIKE UPPER(?) or UPPER(color) LIKE UPPER(?) or UPPER(ope_system) LIKE UPPER(?))and branch_id = #{current_user.branch_id}", "%#{params[:term].strip}%", "%#{params[:term].strip}%", "%#{params[:term].strip}%", "%#{params[:term].strip}%")
    json = computers.collect do |computer| 
      { "id" => computer.id.to_s, 
        "label" => computer.model + " (" + computer.brand + ",  " + computer.ope_system + ",  " + computer.computer_type + ")", 
        "value" => computer.model,
        "ope_system" => computer.ope_system,
        "color" => computer.color,
        "model" => computer.model,
        "brand" => computer.brand,
        "computer_type" => computer.computer_type,
        "hard_drive" => computer.hard_drive,
        "units" => computer.units,
        "memory" => computer.memory,
        "proccessor" => computer.proccessor,
        "charger" => computer.charger,        
        "monitor" => computer.monitor,
        "keyboard" => computer.keyboard,
        "mouse" => computer.mouse
      }
    end
    render json: json, input_html: {update_elements: {}}
  end
  
end
