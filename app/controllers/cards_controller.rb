class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update, :destroy, :show, :add_card_to_guide, :update_card_to_guide]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
    @card.guide_id = params[:guide_id]
  end

  def create
    @card = Card.new(card_params)
    @card = current_user.cards.build(card_params)
    authorize @card
    @guide = @card.guide
    @card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    @markers_new_card = Gmaps4rails.build_markers(@card) do |card, marker|
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
    if @card.save
      respond_to do |format|
        format.html {redirect_to guide_path(@card.guide)}
        format.js # <-- will render `app/views/cards/create.js.erb`
      end
    else
      respond_to do |format|
        format.html {render 'cards/new'}
        format.js
      end
    end
  end

  def add_card_to_guide

  end

  def update_card_to_guide
    @new_card = @card.dup
    @new_card.update(card_params)
    # @new_card.user = current_user
    @new_card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    @new_card.save
    flash[:notice] = "Added to your guide!"
    redirect_to guide_path(@card.guide)
  end

  def edit

  end

  def update
    @card.update(card_params)
    @card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    @card.save
    redirect_to guide_path(@card.guide)
  end

  # def show
  #   @card = Card.find(params[:id])
  # end

  def destroy
    @guide = @card.guide
    @card.destroy
    @cards = @guide.cards
  end



  private

  def card_params
    params.require(:card).permit(:photo, :photo_cache, :banner_picture, :name, :latitude, :longitude, :category, :formatted_address, :international_phone_number, :website, :opening_hours, :price_level, :gphoto, :personnal_note, :guide_id)
  end

  def set_card
    @card = Card.find(params[:id])
    authorize @card
  end
end
