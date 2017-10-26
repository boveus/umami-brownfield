class MessageSender
  def self.send_code(phone, code)
    account_sid = ENV['twilio_sid']
    auth_token  = ENV['twilio_token']
    client = Twilio::REST::Client.new account_sid, auth_token
    
    message = client.messages.create(
      from: ENV['twilio_phone_number'],
      to:   "#{phone}",
      body: code
    )
    
    message.status == 'queued'
  end
end