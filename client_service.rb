require "bundler/setup"
Bundler.require

class ClientService
  def initialize(source_name, source_password, site_id, user_info)
    @site_id = { int: site_id }

    @source_credentials = {
      SourceName: source_name,
      Password: source_password,
      SiteIDs: @site_id,
    }

    @user_info = user_info

    @savon_client = Savon.client(wsdl: "https://api.mindbodyonline.com/0_5/ClientService.asmx?wsdl", pretty_print_xml: true) do
      convert_request_keys_to :none
    end
  end

  def required_client_fields
    request_message = { Request: source_credentials_hash.merge(boilerplate_hash) }
    # @savon_client.operation(:get_required_client_fields).build(message: request_message).to_s
    @savon_client.call(:get_required_client_fields, message: request_message)
  end

  def create_user
    request_message = { Request: create_new_user_message }
    @savon_client.call(:add_or_update_clients, message: request_message)
  end

  private

  def create_new_user_message
    source_credentials_hash.merge(boilerplate_hash).merge(create_user_boilerplate_hash)
  end

  def create_user_credentials(username, password)
    @user_credentials = {
      Username: username,
      Password: password,
      SiteIDs: @site_id,
    }
  end

  def source_credentials_hash
    { SourceCredentials: @source_credentials }
  end

  def boilerplate_hash(detail = "Basic", page_size = 10, current_page_index = 0)
    {
      XMLDetail: detail,
      PageSize: page_size,
      CurrentPageIndex: current_page_index,
    }
  end

  def create_user_boilerplate_hash
    client = { Client: @user_info }

    {
      UpdateAction: "AddNew",
      Test: false,
      Clients: client,
      SendEmail: false,
    }
  end
end
