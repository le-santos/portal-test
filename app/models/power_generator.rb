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
    elsif filtered_query.include?(:manufacturer)
      manufacturer_query = self.where("manufacturer ILIKE ?", "#{filtered_query[:manufacturer]}")
      return @power_generator = manufacturer_query unless filtered_query.include?(:structure_type)

      @power_generators = manufacturer_query.where(structure_type: filtered_query[:structure_type])
    else
      @power_generators = self.where(filtered_query) 
    end
    
  end

end
