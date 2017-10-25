require 'rails_helper'

describe "Users API" do
  it "sends a list of users" do
    create_list(:user, 5)
    
    get '/api/v1/users.json'
    expect(response).to be_success
    users = JSON.parse(response.body)
    expect(users.count).to eq(5)
    expect(users.first.count).to eq(4)
  end
  
  it "sends one user" do
    create_list(:user, 5)
    user = User.last
    
    get "/api/v1/users/#{user.id}.json"
    expect(response).to be_success
    users = JSON.parse(response.body)
    expect(users.count).to eq(4)
    expect(users.first).to eq(["id", 5])
  end
  
  it "sends a user's orders" do
    user  = create(:user)
    item_1  = create(:item)
    item_2  = create(:item)
    order_1 = create(:order, items: [item_1], user: user) 
    order_2 = create(:order, items: [item_1, item_2], user: user)
    
    get "/api/v1/users/#{user.id}/orders.json"
    
    orders = JSON.parse(response.body)
    expect(orders.count).to eq(2)
    expect(orders.first["user_id"]).to eq(1)    
  end
  
  
end