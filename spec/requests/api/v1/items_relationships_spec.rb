require 'rails_helper'

describe "Items relationships API" do
  it "sends orders associated with item" do
    user = create(:user)
    item = create(:item)
    orders = create_list(:order, 5, user_id: user.id)
    item.orders << orders

    get "/api/v1/items/#{item.id}/orders.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json[0]["status"]).to eq(orders[0].status)
    expect(json[1]["status"]).to eq(orders[1].status)
  end

  it "sends orders associated with item" do
    item = create(:item)
    tags = create_list(:tag, 3)
    item.tags << tags

    get "/api/v1/items/#{item.id}/tags.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json[1]["name"]).to eq(tags[0].name)
    expect(json[2]["name"]).to eq(tags[1].name)
    expect(json[3]["name"]).to eq(tags[2].name)
  end
end
