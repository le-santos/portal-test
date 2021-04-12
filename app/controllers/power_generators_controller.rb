require 'via_cep'

class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end
  
  def show
    @power_generator = PowerGenerator.find(params[:id])
  end

  def get_freight
    p_gen_weight = PowerGenerator.find(params[:id]).weight
    address = ViaCep::Address.new(params[:cep])
    state = address.state
    
    @freight = Freight.
                where(state: state).
                where('weight_min <= ? AND weight_max >= ?', 
                        p_gen_weight, p_gen_weight)
    
    render json: @freight
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
    params.require(:search).permit(:simple_query, :structure_type, :manufacturer, :price)
  end
end
