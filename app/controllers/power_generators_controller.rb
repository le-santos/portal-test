class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end
  
  def search
    if search_params.values.any?(&:present?)
      @power_generators = PowerGenerator.search(search_params)
    else
      @power_generators = []
    end
  end

  private

  def search_params
    params.require(:search).permit(:simple_query, :structure_type, :manufacturer)
  end
end
