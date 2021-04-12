class PowerGenerator < ApplicationRecord
  validates :name, :description, :image_url, :manufacturer, :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }

  enum structure_type: %i[
    metalico
    ceramico
    fibrocimento
    laje
    solo
    trapezoidal
  ]

  def self.search(query)
    p '### SEARCH method ###'
    p query
    filtered_query = query.select { |key, value| !value.blank? }
    p filtered_query

    if filtered_query.include?(:simple_query)
      simple = filtered_query[:simple_query]
      @power_generators = self.where('name ILIKE ?', "%#{simple}%")
    else      
      @power_generators = advanced_search(filtered_query)
    end
  end

  def self.advanced_search(parameters)
    structure_type = self.where(structure_type: parameters[:structure_type])
    manufacturer = self.where("manufacturer ILIKE ?", "#{parameters[:manufacturer]}")
    price = self.where("price < ?", "#{parameters[:price].to_f}")
    
    queries = {
      structure_type: structure_type,
      manufacturer: manufacturer,
      price: price
    }

    results = []
    if parameters.keys.size == 1
      results += queries[parameters.keys[0].to_sym]
    else
      parameters.each { |key, value| 
        results << queries[key.to_sym] if value.present?
      }
      results = results.inject(:&)
    end
  end

end
