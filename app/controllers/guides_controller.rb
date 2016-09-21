class GuidesController < ApplicationController
  before_action :set_guide, only: [:edit, :update, :destroy, :show, :filteredfriends]
  skip_before_action :authenticate_user!, :only => :show, :if => lambda {
      if params[:id]
        @guide = Guide.friendly.find(params[:id])
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
        if Card::CATEGORIES[card.category] == "Eat"
          marker.picture({
            :url => "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=glyphish_fork-and-knife|F8E760",
            :width   => 32,
            :height  => 32
          })
        elsif Card::CATEGORIES[card.category] == "Drink"
          marker.picture({
            :url => "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=glyphish_wineglass|FE1544",
            :width   => 32,
            :height  => 32
          })
        elsif Card::CATEGORIES[card.category] == "Sleep"
          marker.picture({
            :url => "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=glyphish_house|89B1FF",
            :width   => 32,
            :height  => 32
          })
        elsif Card::CATEGORIES[card.category] == "Shop"
          marker.picture({
            :url => "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=glyphish_shopping-bag|25AA99",
            :width   => 32,
            :height  => 32
          })
        elsif Card::CATEGORIES[card.category] == "See"
          marker.picture({
            :url => "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=glyphish_eye|EDEDED",
            :width   => 32,
            :height  => 32
          })
        end
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
    @guide = Guide.friendly.find(params[:id])
    authorize @guide
  end

end

