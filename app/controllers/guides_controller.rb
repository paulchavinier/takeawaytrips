class GuidesController < ApplicationController


  def index
    @guide = Guide.all
  end

  def create
    @guide = Guide.new(offer_params)
    @guide.user_id = current_user.id
    if @guide.save
      redirect_to guide_path(current_user.id)
    else
      render 'guide/index'
    end
  end

  def show
    @guide = Guide.find(params[:id])
  end


  private

  def offer_params
    params.require(:guide).permit(:name, :description, :place)
  end


end

