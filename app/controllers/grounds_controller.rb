class GroundsController < ApplicationController
  def show
    ground = Ground.new(language: selected_language)
    @ground = GroundDecorator.new(ground, view_context)
  end

  def shared
    ground = Ground.find(params[:id])
    @ground = GroundDecorator.new(ground, view_context)
    render 'show'
  end

  def share
    @ground = Ground.new(ground_params)

    if @ground.save
      render json: { shared_url: ground_shared_url(@ground) }
    else
      render json: {}, status: :bad_request
    end
  end

  def switch_option
    option, code = params[:option], params[:code]
    if option.present? && code.present? && GroundEditor.has_option?(option, code)
      session[option] = code
    end
    render nothing: true
  end

  private

  def ground_params
    params.require(:ground).permit(:language, :code)
  end
  
  def selected_language
    session[:language] || GroundEditor.default_option_code(:language)
  end
end
