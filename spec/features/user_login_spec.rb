require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  #SETUP
  before :each do
   @user = User.create!(name: 'Severus Snape', email:'severus@snape.com', password: 'potter', password_confirmation: 'potter')
  end

  scenario "They can login with valid credentials" do
    # ACT
    visit root_path

    click_on('Login')
    fill_in 'email', with: 'severus@snape.com'
    fill_in 'password', with: 'potter'
    save_screenshot
    click_on('Submit')

    #VERIFY
    expect(page).to have_text 'Signed in as Severus Snape'
    
    # DEBUG
    save_screenshot

  end
end
