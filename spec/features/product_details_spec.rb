require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name: Faker::Hipster.sentence(2),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )

  end
  
  scenario "They can click on a product and be redirected to that product's page" do
    # ACT
    visit root_path
    first('.product').click_on('Details')

    #VERIFY
    expect(page).to have_css('.product-detail')
    expect(page).to have_text('Name'), count: 1
    expect(page).to have_text('Description'), count: 1
    expect(page).to have_text('Quantity'), count: 1
    expect(page).to have_text('Price'), count: 1

    #DEBUG - PUT THIS AFTER BECAUSE IF BEFORE THE EXPECT IT WAS JUST SCREENSHOTTING THE HOMEPAGE
    save_screenshot
  end
end
