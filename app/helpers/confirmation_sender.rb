class ConfirmationSender
  def self.send_confirmation_to(user)
    verification_code = CodeGenerator.generate
    user.password = "not sure"
    user.update(verification_code: verification_code)
    MessageSender.send_code(user.phone_number, verification_code)
  end
end