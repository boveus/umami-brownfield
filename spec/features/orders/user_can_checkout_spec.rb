require 'rails_helper'

feature "User" do
  context "not logged in " do
    scenario "needs to login or register to checkout" do
      visit cart_path

      expect(page).to have_content('Login or Create Account to Checkout')
    end

    context 'logged in' do
      scenario 'sees checkout button' do
        user = create(:user)
        user.roles << Role.create(name: "registered_user", permission_level: 2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit cart_path

        expect(page).to_not have_content('Login or Create Account to Checkout')
        expect(page).to have_content('Checkout')
      end
    end
  end
end
