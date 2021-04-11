class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end
  
  def search
    p '===== SEARCH params ======'
    p search_params[:structure_type]

    if search_params[:structure_type]
      @power_generators = PowerGenerator.where(structure_type: search_params[:structure_type])
    else
      @power_generators = PowerGenerator.all
    end
  end

  private
  def search_params
    params.require(:search).permit(:structure_type)
  end
end
