class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update, :destroy, :show]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
    @card.guide_id = params[:guide_id]
  end

  def create
    @card = Card.new(card_params)
    @guide = @card.guide
    @card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    @markers_new_card = Gmaps4rails.build_markers(@card) do |card, marker|
      marker.lat card.latitude
      marker.lng card.longitude
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

  def edit
  end

  def update
    @card.update(card_params)
    @card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    @card.save
    redirect_to guide_path(@card.guide)
  end

  def show
    @card = Card.find(params[:id])

  end

  def destroy
    @card.destroy
  end



  private

  def card_params
    params.require(:card).permit(:photo, :photo_cache, :banner_picture, :name, :latitude, :longitude, :category, :formatted_address, :international_phone_number, :website, :opening_hours, :price_level, :gphoto, :personnal_note, :guide_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
