require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    items = create_list(:item, 5)

    get '/api/v1/items.json'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json.count).to eq(5)
    expect(json[0]["price"]).to eq((items[0].price.to_f)/100)
    expect(json[1]["name"]).to eq(items[1].name)
    expect(json[2]["description"]).to eq(items[2].description)
    expect(json[1] ["status"]).to eq(items[1].status)
    expect(json[3] ["created_at"]).to be_nil
    expect(json[4] ["updated_at"]).to be_nil
  end

  it "sends one item by id" do
    items = create_list(:item, 3)

    get "/api/v1/items/#{items[1].id}.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Hash)
    expect(json["price"]).to eq((items[1].price.to_f)/100)
    expect(json["name"]).to eq(items[1].name)
    expect(json["description"]).to eq(items[1].description)
    expect(json["status"]).to eq(items[1].status)
    expect(json["created_at"]).to be_nil
    expect(json["updated_at"]).to be_nil
  end
end
