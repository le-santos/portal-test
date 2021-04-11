require 'rails_helper'

describe 'user searches power generators', js: true do
  context 'by structure type' do
    it 'successfully' do
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
    
    it 'with blank params' do
      FactoryBot.create(:power_generator, {structure_type: :laje})
      FactoryBot.create(:power_generator, {structure_type: :solo})
      FactoryBot.create(:power_generator, {structure_type: :trapezoidal})
  
      visit root_path
      choose 'Pesquisa Avançada'
      within 'form.advanced' do
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content('Sem Resultados')
        expect(page).not_to have_content(/Laje/i)
        expect(page).not_to have_content(/Solo/i)
        expect(page).not_to have_content(/Trapezoidal/i)
      end
    end
  end

  context 'by manufacturer' do
    it 'successfully' do
      FactoryBot.create(:power_generator, {manufacturer: 'WEG'})
      FactoryBot.create(:power_generator, {manufacturer: 'Solar Group'})
      FactoryBot.create(:power_generator, {manufacturer: 'Q Cells'})
  
      visit root_path
      choose 'Pesquisa Avançada'
      within 'form.advanced' do
        fill_in 'Fabricante', with: 'WEG'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content(/weg/i)
        expect(page).not_to have_content(/solar group/i)
      end
    end

    xit 'successfully case insensitive' do
      FactoryBot.create(:power_generator, {manufacturer: 'Solar Group'})
  
      visit root_path
      choose 'Pesquisa Avançada'
      within 'form.advanced' do
        fill_in 'Fabricante', with: 'weg'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content(/weg/i)
        expect(page).not_to have_content(/solar group/i)
      end
    end
  end

  context 'with mixed params' do
  end
end