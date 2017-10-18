require 'rails_helper'

RSpec.feature "A a guest user(customer)" do
  scenario "sees photos and names of businesses" do
    vendors = create_list(:vendor, 3)
    
    visit '/'


    expect(page).to have_content(vendors[0].name)
    expect(page).to have_content(vendors[1].name)
    expect(page).to have_content(vendors[2].name)

  #verify whether or not there will be another link and test for that as well
#save_and_open_page
    click_link vendors[1].name.titleize

    expect(path).to eq("/#{vendors[1].name}/items") #need to figure out url

    expect(page).to have_content(vendor[1].name)
    expect(page).to have_content(vendor[1].image)
    expect(page).to have_content(vendor[1].description)
  end
end
