require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:item_tags) }
  it { is_expected.to have_many(:items) }

  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:created_at) }
  it { is_expected.to have_db_column(:updated_at) }
end
