require 'rails_helper'

RSpec.describe Item, type: :model do
  it {should validate_presence_of :name}
  it {should validate_presence_of :price}
  it {should validate_numericality_of :price}
  #it {should validate_presence_of :tags}
  it {should validate_presence_of :description}

  describe 'Instance Methods' do
    it '#to_money' do
      item = create(:item)

      expect(item.to_money).to eq(0.05)
    end
  end
end
