class SerialNumbersController < ApplicationController
  # GET /serial_numbers
  # GET /serial_numbers.json
  def index
    @serial_numbers = SerialNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @serial_numbers }
    end
  end

  # GET /serial_numbers/1
  # GET /serial_numbers/1.json
  def show
    @serial_number = SerialNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @serial_number }
    end
  end

  # GET /serial_numbers/new
  # GET /serial_numbers/new.json
  def new
    @serial_number = SerialNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @serial_number }
    end
  end

  # GET /serial_numbers/1/edit
  def edit
    @serial_number = SerialNumber.find(params[:id])
  end

  # POST /serial_numbers
  # POST /serial_numbers.json
  def create
    @serial_number = SerialNumber.new(params[:serial_number])

    respond_to do |format|
      if @serial_number.save
        format.html { redirect_to @serial_number, notice: 'Serial number was successfully created.' }
        format.json { render json: @serial_number, status: :created, location: @serial_number }
      else
        format.html { render action: "new" }
        format.json { render json: @serial_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /serial_numbers/1
  # PUT /serial_numbers/1.json
  def update
    @serial_number = SerialNumber.find(params[:id])

    respond_to do |format|
      if @serial_number.update_attributes(params[:serial_number])
        format.html { redirect_to @serial_number, notice: 'Serial number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @serial_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /serial_numbers/1
  # DELETE /serial_numbers/1.json
  def destroy
    @serial_number = SerialNumber.find(params[:id])
    @serial_number.destroy

    respond_to do |format|
      format.html { redirect_to serial_numbers_url }
      format.json { head :no_content }
    end
  end
  
  def serial_number_with_part
    @serial_number = SerialNumber.joins("INNER JOIN parts p ON serial_numbers.part_id = p.id").select { |s| params[:part_name] == "(#{s.serial_number}) #{s.part.name}" } || {}
    unless @serial_number.blank?
      @serial_number = @serial_number[0]
      @serial_number[:id] = @serial_number.id
      @serial_number[:serial_number] = @serial_number.serial_number
      @serial_number[:part_name] = @serial_number.part.name
      @serial_number[:part_cost] = @serial_number.part.cost
    end
    render json: @serial_number
  end
end