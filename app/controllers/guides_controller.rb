class GuidesController < ApplicationController
  before_action :set_guide, only: [:edit, :update, :destroy, :show]


  def index
    @guide = Guide.new
  end

  def create
    @guide = Guide.new(offer_params)
    @guide.user_id = current_user.id
    if @guide.save
      redirect_to guides_path
    else
      render 'root/index'
    end
  end

  def show
  end

  def edit
  end


  private

  def offer_params
    params.require(:guide).permit(:name, :description, :place)
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

end

