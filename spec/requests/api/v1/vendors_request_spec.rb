require 'rails_helper'

describe "Vendors API" do
  it "sends a list of vendors" do
    create_list(:vendor, 5)

    get '/api/v1/vendors.json'

    expect(response).to be_success

    vendors = JSON.parse(response.body)

    expect(vendors.count).to eq(5)
    expect(vendors.class).to eq(Array)
    expect(vendors[1]["created_at"]).to be_nil
    expect(vendors[0]["updated_at"]).to be_nil
    expect(vendors[2]["image"]).to be_nil
  end

  it "sends one vendor by id" do
    vendors = create_list(:vendor, 3)

    get "/api/v1/vendors/#{vendors[1].id}.json"

    json = JSON.parse(response.body)
    expect(response).to be_success
    expect(json.class).to eq(Hash)
    expect(json["name"]).to eq(vendors[1].name)
    expect(json["description"]).to eq(vendors[1].description)
    expect(json["updated_at"]).to be_nil
  end
end

