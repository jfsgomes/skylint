require_relative "client"
require "bundler/setup"
Bundler.require

class ClassService
  def initialize(source_name, source_password, site_id, client_id, class_id, username, password)
    @source_name = source_name
    @source_password = source_password
    @site_id = { int: site_id }
    @client_id = { string: client_id }
    @class_id = { int: class_id }
    @username = username
    @password = password

    @savon_client = Savon.client(wsdl: "https://api.mindbodyonline.com/0_5/ClassService.asmx?wsdl", pretty_print_xml: true) do
      convert_request_keys_to :none
    end
  end

  def add_user_to_class
    request_message = { Request: create_add_user_to_class_message }
    @savon_client.call(:add_clients_to_classes, message: request_message)
  end

  private

  def create_add_user_to_class_message
    source_credentials_hash.
      merge(user_credentials_hash).
      merge(boilerplate_hash).
      merge(add_user_to_class_boilerplate_hash)
  end

  def user_credentials_hash
    user_credentials = {
      Username: @username,
      Password: @password,
      SiteIDs: @site_id,
    }

    { UserCredentials: user_credentials }
  end

  def source_credentials_hash
    source_credentials = {
      SourceName: @source_name,
      Password: @source_password,
      SiteIDs: @site_id,
    }

    { SourceCredentials: source_credentials }
  end

  def boilerplate_hash(detail = "Basic", page_size = 10, current_page_index = 0)
    {
      XMLDetail: detail,
      PageSize: page_size,
      CurrentPageIndex: current_page_index,
    }
  end

  def add_user_to_class_boilerplate_hash
    {
      ClientIDs: @client_id,
      ClassIDs: @class_id,
      Test: false,
      RequirePayment: false,
    }
  end
end
