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
    
    user = JSON.parse(response.body)
    expect(user.count).to eq(4)
    expect(user["id"]).to eq(user_1.id)
    expect(user["name"]).to eq(user_1.name)
    
    get "/api/v1/orders/#{order_2.id}/user.json"
    
    user = JSON.parse(response.body)
    expect(user["id"]).to eq(user_2.id)
    expect(user["name"]).to eq(user_2.name)
  end
  
  it "can get an orders's items" do
    user_1 = create(:user)
    user_2 = create(:user)
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    orders_1 = create_list(:order, 5, user: user_1, items: [item_1])
    orders_2 = create_list(:order, 5, user: user_2, items: [item_2, item_3])
    order_1 = Order.first
    order_2 = Order.last
    
    get "/api/v1/orders/#{order_1.id}/items.json"
    
    items = JSON.parse(response.body)
    expect(items.count).to eq(order_1.items.count)
    expect(items.first["name"]).to eq(item_1.name)
     
    get "/api/v1/orders/#{order_2.id}/items.json"
    
    items = JSON.parse(response.body)
    expect(items.count).to eq(order_2.items.count)
  end
end