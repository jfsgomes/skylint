require "savon"

class BaseService
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def call(operation, payload = {})
    client.call(operation,
      message: {
        "Request" => request_base.merge(payload),
      })
  end

  def build(operation, payload = {})
    client.operation(operation).build(
      message: {
        "Request" => request_base.merge(payload),
      },
    )
  end

  def client
    @_client ||= Savon.client(
      wsdl: "https://api.mindbodyonline.com/0_5/#{name}Service.asmx?wsdl",
      convert_request_keys_to: :none,
      namespace_identifier: nil,
      namespaces: namespaces,
      pretty_print_xml: true,
    )
  end

  def namespaces
    {

    }
  end

  def request_base
    {
      "SourceCredentials" => source_credentials,
      "UserCredentials" => user_credentials,
      "XMLDetail" => "Full",
      "PageSize" => 10,
      "CurrentPageIndex" => 0,
    }
  end

  def source_credentials
    {
      "SourceName" => source_name,
      "Password" => source_password,
      "SiteIDs" => {
        int: -99,
      },
    }
  end

  def user_credentials
    {
      "Username" => "Siteowner",
      "Password" => "apitest1234",
      "SiteIDs" => {
        int: -99,
      },
    }
  end

  def source_name
    @_source_name ||= ENV.fetch("SOURCE_USERNAME")
  end

  def source_password
    @_source_password ||= ENV.fetch("SOURCE_PASSWORD")
  end
end
