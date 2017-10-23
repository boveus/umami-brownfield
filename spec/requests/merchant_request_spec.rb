require 'rails_helper'

describe "Merchants API" do
  it "sends a list of vendors" do
    create_list(:vendor, 5)

    get '/api/v1/vendors.json'

    expect(response).to be_success
  end
end

