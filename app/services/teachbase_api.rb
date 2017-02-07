require 'rest-client'

class TeachbaseApi
  TEACHBASE_URL = 'http://s1.teachbase.ru'

  def initialize(client_key = nil, secret_key = nil)
    @client_key = client_key || ENV['CLIENT_KEY']
    @secret_key = secret_key || ENV['SECRET_KEY']
  end

  def get_token
    response = RestClient.post TEACHBASE_URL + '/oauth/token', {
        grant_type: 'client_credentials',
        client_id: @client_key,
        client_secret: @secret_key
    }
    JSON.parse(response)['access_token']
  end

  def get(request_path)
    RestClient.get TEACHBASE_URL + request_path, { 'Authorization' => "Bearer #{get_token}"}
  end
end