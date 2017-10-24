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
end
