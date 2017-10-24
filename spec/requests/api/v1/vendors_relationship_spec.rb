require 'rails_helper'

describe "Vendors relationships API" do
  it "sends items associated with vendor" do
    vendor = create(:vendor)
    items = create_list(:item, 5, vendor_id: vendor.id)

    get "/api/v1/vendors/#{vendor.id}/items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json[2]["name"]).to eq(items[2].name)
    expect(json[2]["created_at"]).to be_nil
  end

  it "sends users associated with vendor" do
    vendor = create(:vendor)
    users = create_list(:user, 3, vendor_id: vendor.id)

    get "/api/v1/vendors/#{vendor.id}/users"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json.count).to eq(3)
    expect(json[0]["name"]).to eq(users[0].name)
    expect(json[1]["email"]).to eq(users[1].email)
    expect(json[2]["address"]).to eq(users[2].address)
    expect(json[0]["image"]).to be_nil
    expect(json[1]["created_at"]).to be_nil
    expect(json[2]["role"]).to be_nil
    expect(json[0]["updated_at"]).to be_nil
    expect(json[1]["uid"]).to be_nil
  end
end
