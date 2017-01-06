require "base_service"

class SaleService < BaseService
  def initialize
    super(name: "Sale")
  end

  def checkout_shopping_cart(client_id:, service_id:, service_value:, quantity:)
    payload = checkout_shopping_cart_payload(
      client_id: client_id,
      service_id: service_id,
      service_value: service_value,
      quantity: quantity,
    )

    build(:checkout_shopping_cart, payload)
  end

  private

  def checkout_shopping_cart_payload(client_id:, service_id:, service_value:, quantity:)
    {
      "ClientID" => client_id,
      Test: false,
      CartItems: {
        CartItem: {
          Quantity: quantity,
          Item: {
            "@xsi:type" => "Service",
            "ID" => service_id,
          },
        },
      },
      Payments: {
        PaymentInfo: cash_payment_info(amount: service_value),
      },
      SendEmail: false,
    }
  end

  def cash_payment_info(amount:)
    {
      "@xsi:type" => "CashInfo",
      "Amount" => amount,
    }
  end
end
