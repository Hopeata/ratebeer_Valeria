require 'rails_helper'

describe "Beer" do

  it "can be added with valid name" do
  visit new_beer_path
    fill_in('beer_name', with:'Humala')
    select('Lager', from:'beer_style')
  expect{
    click_button "Create Beer"
  }.to change{Beer.count}.from(0).to(1)
  end

  it "is redirected back to new beer form if name is not given" do
    visit new_beer_path
    fill_in('beer_name', with:'')
    select('Lager', from:'beer_style')

    expect(current_path).to eq(new_beer_path)
    expect(page).to have_content 'Name cannot be blank'
  end

  it "cannot be saved with invalid name" do
    visit new_beer_path
    select('Lager', from: 'beer_style')
    click_button "Create Beer"
    expect(Beer.count).to eq(0)
  end
end