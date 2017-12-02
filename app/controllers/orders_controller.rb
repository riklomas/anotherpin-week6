class OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
    @order.add_from_cart(@current_cart)
  end
  
  def create
    @order = Order.new(form_params)
    @order.add_from_cart(@current_cart)
    
    if @order.save
      reset_session
      
      flash[:success] = "Order completed"
            
      redirect_to order_path(@order)
    else
      render "new"
    end
    
  end
  
  def form_params
    params.require(:order).permit(:first_name, :last_name, :email,
      :country, :address_1, :address_2, :city, :postal_code)
  end
  
end
