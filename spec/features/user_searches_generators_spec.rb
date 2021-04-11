require 'rails_helper'

describe 'user searches power generators' do
  Capybara.current_driver = :selenium_headless

  it 'by structure type' do
    FactoryBot.create(:power_generator, {structure_type: :laje})
    FactoryBot.create(:power_generator, {structure_type: :solo})
    FactoryBot.create(:power_generator, {structure_type: :trapezoidal})

    visit root_path
    choose 'Pesquisa Avançada'
    within 'form.advanced' do
      select 'Laje', from: 'search_structure_type'
      click_on 'Pesquisar'
    end

    expect(current_path).to eq search_path
    within 'div.search-results' do
      expect(page).to have_content(/Laje/i)
      expect(page).not_to have_content(/Solo/i)
      expect(page).not_to have_content(/Trapezoidal/i)
    end
  end
end