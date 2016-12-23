require_relative "class_service"
require_relative "client_service"
require_relative "client"

require "bundler/setup"
Bundler.require

require "dotenv"
Dotenv.load

user_info = Client.new.info("Jorge11995", "Jesus19123949", "Jose", "Grandetrap123", "jose@trap.pt", "1990-12-20", "Male", "123456789", "123 ST Grand #100", "Canyon", "CA", "90000", "Jodan Gretb")
class_id = 24483

randomtest1 = ClientService.new(ENV["SOURCE_USERNAME"], ENV["SOURCE_PASSWORD"], ENV["SITE_ID"], user_info)
response1 = randomtest1.create_user
new_user = response1.body[:add_or_update_clients_response][:add_or_update_clients_result][:clients][:client]

puts response1.body

puts "User created #{new_user[:id]}"

randomtest2 = ClassService.new(ENV["SOURCE_USERNAME"], ENV["SOURCE_PASSWORD"], ENV["SITE_ID"], new_user[:id], class_id, "Siteowner", "apitest1234")
response2 = randomtest2.add_user_to_class

puts response2.body
