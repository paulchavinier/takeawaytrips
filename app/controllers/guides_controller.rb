class GuidesController < ApplicationController
  before_action :set_guide, only: [:edit, :update, :destroy, :show]


  def index
    @guide = Guide.new
  end

  def create
    @guide = Guide.new(guide_params)
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

  def update
    @guide.update(guide_params)
    redirect_to @guide
  end

  def destroy
    @guide.destroy
    redirect_to :back
  end

  private

  def guide_params
    params.require(:guide).permit(:name, :description, :place, :latitude, :longitude)
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

end

