class OrderMailer < ApplicationMailer

  def receipt(order)
    # we want to use @order in our views
    @order = order

    mail to: @order.email, subject: "Thank you for ordering from Another Pin Co"
  end
end
