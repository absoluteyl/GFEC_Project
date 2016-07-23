class OrderNotifier < ApplicationMailer
  default from: 'RiRiKoKo <donot-reply@ririkoko.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order
    mail to: order.buyer.email, subject: 'RiRiKoKo Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.buyer.email, subject: 'RiRiKoKo Order Shipped'
  end
end
