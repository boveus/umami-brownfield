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
  
  it "sends a tag's items" do
    tag = create(:tag)
    item_1 = create(:item, tags: [tag])
    item_2 = create(:item, tags: [tag])
    
    get "/api/v1/tags/#{tag.id}/items.json"
    
    items = JSON.parse(response.body)
    expect(items[0]["name"]).to eq(item_1.name)
    expect(items[1]["name"]).to eq(item_2.name)
    
  end
end