module Diplomacy
  Twilio.configure do |config|
    config.account_sid = DiploConfig.account_sid
    config.auth_token = DiploConfig.auth_token
  end

  def self.twilio_client
    Twilio::REST::Client.new(account_sid: DiploConfig.account_sid, auth_token: DiploConfig.auth_token)
  end
end