require 'rails_helper'

describe "Users API" do
  it "sends a list of users" do
    create_list(:user, 5)
    
    get '/api/v1/users.json'
    expect(response).to be_success
    users = JSON.parse(response.body)
    expect(users.count).to eq(5)
    expect(users.first.count).to eq(16)
  end
  
  it "sends one user" do
    create_list(:user, 5)
    user = User.last
    
    get "/api/v1/users/#{user.id}.json"
    expect(response).to be_success
    users = JSON.parse(response.body)
    expect(users.count).to eq(16)
    expect(users.first).to eq(["id", 5])
  end
end