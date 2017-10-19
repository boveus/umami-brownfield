# As a guest user
# When I visit "/login"
# And I click "Forgot my Password"
# Then I should be on '/password-reset'
# 
# When I fill in `Email` with "josh@example.com"
# And I click `Submit`
# Then I should be redirected to "/password-confirmation"
# And I should see instructions to enter my confirmation code
# And I should have received a text message with a confirmation code
# 
# When I enter the confirmation code
# And I fill in `Password` with `password`
# And I fill in `Password Confirmation` with `password`
# And I click "Submit"
# Then I should be redirected to "/dashboard"
# And I should be logged in
# And my old password should no longer work for logging in
# And my new password should work after logging out and logging back in