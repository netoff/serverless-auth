class ApplicationController < ActionController::Base
  before_action :authenticate_api

  private

  def authenticate_api
    puts "request headers->>" + request.headers.inspect
    authenticate_or_request_with_http_token do |api_key, _|
      puts "api_key => " + api_key
      decoded_key = ::Base64.strict_decode64(api_key)
      puts "api_key 2=> " + decoded_key
      admin = Admin.find_by api_key: decoded_key
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      api_key.present? && ActiveSupport::SecurityUtils.secure_compare(decoded_key, (admin&.api_key || ''))
    end
  end
end
