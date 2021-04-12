require 'rails_helper'

describe 'user searches power generators', js: true do
  context 'with simple search' do
    it 'successfully' do
      FactoryBot.create(:power_generator, {name: 'FRONIUS Laje'})
      FactoryBot.create(:power_generator, {name: 'SMA SOLO'} )
  
      visit root_path
      choose 'Pesquisa Simples'
      within 'form.simple' do
        fill_in 'search_simple_query', with: 'laje'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content(/Laje/i)
        expect(page).not_to have_content(/Solo/i)
      end
    end

    it 'does not find results' do
      FactoryBot.create(:power_generator, {name: 'FRONIUS CELL'})
      FactoryBot.create(:power_generator, {name: 'SMA SOLO'} )
  
      visit root_path
      choose 'Pesquisa Simples'
      within 'form.simple' do
        fill_in 'search_simple_query', with: 'laje'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content('Sem Resultados')
      end
    end
  end

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

    it 'successfully case insensitive' do
      FactoryBot.create(:power_generator, {manufacturer: 'WEG'})
  
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

  context 'by price' do
    it 'successfully' do
      FactoryBot.create(:power_generator, {manufacturer: 'WEG', price: 2958.50 })
      FactoryBot.create(:power_generator, {manufacturer: 'Q CELLS',price: 12223.73})
      FactoryBot.create(:power_generator, {manufacturer: 'BYD', price: 32223.73})

      visit root_path
      choose 'Pesquisa Avançada'
      within 'form.advanced' do
        select '10.000', from: 'search_price'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content(/weg/i)
        expect(page).to have_content('2.958,50')
        expect(page).not_to have_content(/q cells/i)
        expect(page).not_to have_content(/byd/i)
      end
    end
  end

  context 'with multiple params' do
    it 'successfully' do
      FactoryBot.create(:power_generator, {manufacturer: 'WEG', structure_type: :laje, price: 15000})
      FactoryBot.create(:power_generator, {manufacturer: 'Q Cells', structure_type: :laje, price: 12000})
      FactoryBot.create(:power_generator, {manufacturer: 'WEG', structure_type: :solo, price: 30000})
  
      visit root_path
      choose 'Pesquisa Avançada'
      within 'form.advanced' do
        fill_in 'Fabricante', with: 'WEG'
        select 'Laje', from: 'search_structure_type'
        select '20.000', from: 'search_price'
        click_on 'Pesquisar'
      end
  
      expect(current_path).to eq search_path
      within 'div.search-results' do
        expect(page).to have_content(/weg/i)
        expect(page).not_to have_content(/solar group/i)
        expect(page).not_to have_content(/q cells/i)
        expect(page).not_to have_content(/solo/i)
      end
    end
  end
end