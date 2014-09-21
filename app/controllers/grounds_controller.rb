class GroundsController < ApplicationController
  def show
    ground = Ground.new(language: selected_language, code: '')
    @ground = GroundDecorator.new(ground, view_context)
  end

  def shared
    ground = Ground.from_storage!(params[:id])
    @ground = GroundDecorator.new(ground, view_context)
    render 'show'
  end

  def share
    @ground = Ground.new(ground_params)
    @ground.save

    if @ground.persisted?
      render json: { status: :ok, shared_url: ground_shared_url(@ground.id) }
    else
      render json: { status: :service_unavailable }
    end
  end

  def switch_option
    option, code = params[:option], params[:code]
    if option.present? && code.present? && GroundEditor.has_option?(option, code)
      session[option] = code
    end
    render json: { status: :ok }
  end

  private

  def ground_params
    params.require(:ground).permit(:language, :code)
  end
  
  def selected_language
    session[:language] || GroundEditor.default_option_code(:language)
  end
end
