require_relative "class_service"
require_relative "client_service"
require "sale_service"
require_relative "client"

require "bundler/setup"
Bundler.require

id = 123
user_info = Client.new.info("aqueleuser#{id}", "aquelapass#{id}", "Jose", "Grandetrap#{id}", "jose@trap.pt", "1990-12-20", "Male", "123456789", "123 ST Grand #100", "Canyon", "CA", "90000", "Jodan Gretb")
class_id = 24483
service_id = 1300
service_value = 55
quantity = 1

randomtest1 = ClientService.new(ENV["SOURCE_USERNAME"], ENV["SOURCE_PASSWORD"], ENV["SITE_ID"], user_info)
response1 = randomtest1.create_user
new_user = response1.body[:add_or_update_clients_response][:add_or_update_clients_result][:clients][:client]

randomtest2 = ClassService.new(ENV["SOURCE_USERNAME"], ENV["SOURCE_PASSWORD"], ENV["SITE_ID"], new_user[:id], class_id, "Siteowner", "apitest1234")
response2 = randomtest2.add_user_to_class

sale_service = SaleService.new
request = sale_service.checkout_shopping_cart(
  client_id: new_user[:id],
  service_id: service_id,
  service_value: service_value,
  quantity: quantity,
)
puts request.to_s
