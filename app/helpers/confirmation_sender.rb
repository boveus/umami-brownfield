class ConfirmationSender
  def self.send_confirmation_to(user)
    verification_code = CodeGenerator.generate
    user.password = "not sure"
    user.update(verification_code: verification_code, phone_number: "+13039296066")
    MessageSender.send_code(user.phone_number, verification_code)
  end
end