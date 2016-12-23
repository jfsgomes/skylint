require_relative "client_service"
require_relative "client"

require "bundler/setup"
Bundler.require

require "dotenv"
Dotenv.load

user_info = Client.new.info("aqueleuser2", "aquelapass2", "Jose", "Trap", "jose@trap.pt", "1990-12-20", "Male", "123456789", "123 ST Grand #100", "Canyon", "CA", "90000", "Jodan Gretb")
randomtest = ClientService.new(ENV["SOURCE_USERNAME"], ENV["SOURCE_PASSWORD"], ENV["SITE_ID"], user_info)
response = randomtest.create_user

puts response.body
