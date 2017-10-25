require 'rails_helper'

describe "Tags API" do
  it "sends a list of tags" do
    create_list(:tag, 5)
    
    get '/api/v1/tags.json'
    
    tags = JSON.parse(response.body)
    expect(tags.count).to eq(5)
    expect(tags.first.count).to eq(4)
  end
  
  it "sends one tag" do
    create_list(:tag, 5)
    tag = Tag.last
    
    get "/api/v1/tags/#{tag.id}.json"
    
    tags = JSON.parse(response.body)
    expect(tags.count).to eq(4)
    expect(tag["id"]).to eq(tag.id)
    expect(tag["name"]).to eq(tag.name)
  end
end