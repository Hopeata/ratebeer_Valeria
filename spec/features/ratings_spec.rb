require 'rails_helper'


describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) {FactoryGirl.create :user, username:"Pirjo", password:"Secret1", password_confirmation:"Secret1"}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
#    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows the number of ratings" do
  r = FactoryGirl.create(:rating, beer:beer1, user:user)
  r2 = FactoryGirl.create(:rating2, beer:beer1, user:user)
  r3 = FactoryGirl.create(:rating3, beer:beer1, user:user)
    visit ratings_path
    expect(page).to have_content 'Number of ratings: 3'
  end

  it "shows user's own ratings" do
    r = FactoryGirl.create(:rating, beer:beer1, user:user)
    r = FactoryGirl.create(:rating, beer:beer1, user:user2)
    visit user_path(user)
    expect(page).to have_content 'Has 1 rating'
  end

  it "is deleted correctly" do
    r = FactoryGirl.create(:rating, beer:beer1, user:user)
    visit user_path(user)
    expect {
      click_link "delete"
    }.to change{Rating.count}.from(1).to(0)
  end

end