class MessageSender
  def self.send_code(phone, code)
    account_sid = ENV['twillio_sid']
    auth_token  = ENV['twillio_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)
    
    messaage = client.messages.create(
      from: ENV['twilio_phone_number'],
      to:   phone,
      body: code
    )
    
    message.status == 'queued'