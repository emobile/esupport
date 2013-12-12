module OrdersHelper
  def  create_product(product_type)
    if product_type == "Cellphone"
      @order.brand = params[:order][:brand]
      @order.model = params[:order][:model]
      @order.color = params[:order][:color]
      @order.ope_system = params[:order][:ope_system]
      @order.imei = params[:order][:imei]
      @product = Cellphone.create(:brand => @order.brand, :model => @order.model, :color => @order.color, :ope_system => @order.ope_system, :imei => @order.imei, :client_id => @order.client_id, :branch_id => @order.branch_id)
    end
    if product_type == "Computer"
      @order.brand = params[:order][:brand]
      @order.model = params[:order][:model]
      @order.ope_system = params[:order][:ope_system]
      @order.serial_number = params[:order][:serial_number]
      @order.computer_type = params[:order][:computer_type]
      @order.hard_drive = params[:order][:hard_drive]
      @order.units = params[:order][:units]
      @order.memory = params[:order][:memory]
      @order.proccessor = params[:order][:proccessor]
      @order.color = params[:order][:color]
      @order.charger = params[:order][:charger]
      @order.usb = params[:order][:usb]
      @order.monitor = params[:order][:monitor]
      @order.keyboard = params[:order][:keyboard]
      @order.mouse = params[:order][:mouse]
      @product = Computer.create(:brand => @order.brand, 
        :model => @order.model, 
        :ope_system => @order.ope_system, 
        :serial_number => @order.serial_number,  
        :computer_type => @order.computer_type, 
        :hard_drive => @order.hard_drive, 
        :units => @order.units, 
        :memory => @order.memory, 
        :processor => @order.processor, 
        :color => @order.color,
        :charger => @order.charger,
        :usb => @order.usb,
        :monitor => @order.monitor,
        :keyboard => @order.keyboard,
        :mouse => @order.mouse,
        :client_id => @order.client_id, :branch_id => @order.branch_id)   
    end
  end  
end
