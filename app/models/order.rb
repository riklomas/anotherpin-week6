class Order < ApplicationRecord
  has_many :order_items
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  
  accepts_nested_attributes_for :order_items
  
  def add_from_cart(cart)
    cart.order_items.all.each do |item|
      self.order_items.build(product: item.product, quantity: item.quantity)
    end    
  end
  
  def save_and_charge
    # check our data is valid
    # if it is, charge in stripe
    # if it isn't, return false
    # charge in stripe and save if all good
    # if charge declined in stripe, return an error
    if self.valid?
      
      Stripe::Charge.create(amount: self.total_price, currency: "usd", 
        source: self.stripe_token, description: "Order for " + self.email)
      
      self.save
    else
      # doesn't pass validations
      false
    end
    
  rescue Stripe::CardError => e
    # this is from stripe
    @message = e.json_body[:error][:message]
    
    # then add to the model errors
    self.errors.add(:stripe_token, @message)
    
    # return false to our controller
    false    
  end
  
  
  
  
  def total_price
    @total = 0
    
    order_items.each do |item|
      @total = @total + item.product.price * item.quantity
    end
    
    @total
  end
  
  
  def total_price_in_dollars
    @total = 0
    
    order_items.all.each do |item|
      @total = @total + item.product.price_in_dollars * item.quantity
    end
    
    @total
  end
  
  
end





