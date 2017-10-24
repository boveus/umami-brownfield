require 'rails_helper'

describe "Orders API" do
  it "sends a list of orders" do
    user_1 = create(:user)
    user_2 = create(:user)
    orders_1 = create_list(:order, 5, user: user_1)
    orders_2 = create_list(:order, 5, user: user_2)
    
    get 'api/v1/orders.json'
    
    expect(response).to be_success
    orders = JSON.parse(response.body)
    expect(orders.count).to eq(20)
    expect(orders.first.count).to eq(5)
    
    
  end
end