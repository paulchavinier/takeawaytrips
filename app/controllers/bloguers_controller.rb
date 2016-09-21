class BloguersController < ApplicationController

skip_before_action :authenticate_user!, :only => :show

  def new
    @guide = Guide.new
    @guide.user_id = params[:user_id]
  end

  def create
    @bloguer = Bloguer.new(bloguer_params)

  end

  def show
    @bloguer = Bloguer.friendly.find(params[:id])
    @guides = @bloguer.user.guides
    authorize @bloguer
  end

  private

  def bloguer_params
    params.require(:bloguer).permit(:name, :author, :short_desc, :long_desc, :location, :facebook, :instagram, :twitter, :website, :profile_pic, :banner, :user_id)
  end


end
