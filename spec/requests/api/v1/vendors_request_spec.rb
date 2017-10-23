require 'rails_helper'

describe "Vendors API" do
  it "sends a list of vendors" do
    create_list(:vendor, 5)

    get '/api/v1/vendors.json'

    expect(response).to be_success
    vendors = JSON.parse(response.body)
    expect(vendors.count).to eq(5)
    expect(vendors.class).to eq(Array)
  end
end

