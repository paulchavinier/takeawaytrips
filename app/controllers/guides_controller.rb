class GuidesController < ApplicationController
  before_action :set_guide, only: [:edit, :update, :destroy, :show, :filteredfriends]
  skip_before_action :authenticate_user!, :only => :show, :if => lambda {
      if params[:id]
        @guide = Guide.find(params[:id])
        @guide.privacy == "public"
      else
        false
      end
    }


  def index
    @guide = Guide.new
    #@guides = current_user.guides
    @guides = policy_scope(Guide) # ca remplace le @guides et on met dans pundit la façon dont on accède aux guides
    @markersguide = Gmaps4rails.build_markers(@guides) do |guide, marker| # construction duJson pour pousser a Gplace for Rails
      marker.lat guide.latitude
      marker.lng guide.longitude
      marker.title guide.place_type
    end
  end

  def create
    # @guide = Guide.new(guide_params)
    @guide = current_user.guides.build(guide_params)
    authorize @guide

    unless @guide.valid?
      return respond_to do |format|
        format.html { render :new }
        format.js  # <-- idem
      end
    end

    # @guide.user_id    = current_user.id
    results           = Geocoder.search(@guide.place)
    @guide.place_type = results.first.types.first
    # results.first.data["address_components"][3]["long_name"]
    # Geocoder.search(@guide.place).first.data["address_components"][3]["long_name"]

    if @guide.save
      respond_to do |format|
        format.html { redirect_to guide_path(@guide) }
        format.js  # <-- will render `app/views/guides/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js  # <-- idem
      end
    end
  end

  def show
    @card = Card.new
    @card.guide_id = params[:id]
    @category = params[:category]
    if @category
      @cards = @guide.cards.where(category: Card::CATEGORIES_MAPPING[@category])
    else
      @cards = @guide.cards
    end
    @categories = Card::CATEGORIES.values.uniq
    @markers = Gmaps4rails.build_markers(@cards) do |card, marker|
      marker.lat card.latitude
      marker.lng card.longitude
      marker.infowindow "<a data-toggle='modal' data-target='#cardModal_#{card.id}'>#{card.name}</a>"
    end
    @markersguide = Gmaps4rails.build_markers(@guide) do |guide, marker| # construction duJson pour pousser a Gplace for Rails
      marker.lat guide.latitude
      marker.lng guide.longitude
      marker.title guide.place_type
      marker
    end
  end

  def edit
  end

  def update
    @guide.update(guide_params)
    redirect_to guides_path
  end

  def destroy
    @guide.destroy
    redirect_to :back
  end

  def filteredfriends
    @filteredfriends = @guide.friendlist_filtered
  end

  private

  def guide_params
    params.require(:guide).permit(:name, :description, :place, :latitude, :longitude, :photo, :photo_cache, :gphoto, :privacy)
  end

  def set_guide
    @guide = Guide.find(params[:id])
    authorize @guide
  end

end

