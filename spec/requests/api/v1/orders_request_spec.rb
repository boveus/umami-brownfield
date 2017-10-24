require 'rails_helper'

describe "Orders API" do
  it "sends a list of orders" do
    user_1 = create(:user)
    user_2 = create(:user)
    orders_1 = create_list(:order, 5, user: user_1)
    orders_2 = create_list(:order, 5, user: user_2)
    
    get '/api/v1/orders.json'
    expect(response).to be_success
    orders = JSON.parse(response.body)
    expect(orders.count).to eq(10)
    expect(orders.first.count).to eq(5)
  end
  it "sends one order" do
    user_1 = create(:user)
    user_2 = create(:user)
    orders_1 = create_list(:order, 5, user: user_1)
    orders_2 = create_list(:order, 5, user: user_2)
    order = Order.last
    
    get "/api/v1/orders/#{order.id}.json"
    
    expect(response).to be_success
    orders = JSON.parse(response.body)
    expect(orders.count).to eq(5)
    expect(orders.first).to eq(["id", 10])
  end
end