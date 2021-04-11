class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end
  
  def search
    p '===== SEARCH params ======'
    p search_params

    if search_params.values.any?(&:present?)
      @power_generators = PowerGenerator.search(search_params)
    else
      @power_generators = []
    end
  end

  private

  def search_params
    params.require(:search).permit(:structure_type, :manufacturer)
  end
end
