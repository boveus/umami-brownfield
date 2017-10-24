require 'rails_helper'

describe "Users API" do
  it "sends a list of users" do
    create_list(:user, 5)
    
    get 'api'
  end
end