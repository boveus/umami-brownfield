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
    order = JSON.parse(response.body)
    expect(order.count).to eq(5)
    expect(order["id"]).to eq(10)
    expect(order["user_id"]).to eq(2)
  end
  
  it "can find an order's user" do
    user_1 = create(:user)
    user_2 = create(:user)
    orders_1 = create_list(:order, 5, user: user_1)
    orders_2 = create_list(:order, 5, user: user_2)
    order_1 = Order.first
    order_2 = Order.last
    
    get "/api/v1/orders/#{order_1.id}/user.json"
    
    expect(order_1.count).to eq(5)
    expect(order_1[1]).to eq(["id", 1])
    expect(order_1[2]).to eq(["user_id", 1])
    
    get "/api/v1/orders/#{order_2.id}/user.json"
    
    expect(order_1[1]).to eq(["id", 1])
    expect(order_1[2]).to eq(["user_id", 1])
  end
end