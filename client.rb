require "bundler/setup"
Bundler.require

class Client
  def info(username, password, first_name, last_name, email, birth_date, gender, mobile_phone, address, city, state, postal_code, reference)
    {
      Username: username,
      Password: password,
      FirstName: first_name,
      LastName: last_name,
      Email: email,
      BirthDate: birth_date,
      Gender: gender,
      MobilePhone: mobile_phone,
      AddressLine1: address,
      City: city,
      State: state,
      PostalCode: postal_code,
      ReferredBy: reference,
    }
  end
end
