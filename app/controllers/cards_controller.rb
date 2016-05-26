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
    @card.opening_hours = card_params[:opening_hours].split(',') if card_params[:opening_hours]
    if @card.save
      redirect_to guide_path(@card.guide)
    else
      render 'cards/new'
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
    @cards = []
    @cards << @card
  end

  def destroy
    @card.destroy
    redirect_to guide_path(@card.guide)
  end

  private

  def card_params
    params.require(:card).permit(:photo, :photo_cache, :banner_picture, :name, :latitude, :longitude, :category, :formatted_address, :international_phone_number, :website, :opening_hours, :price_level, :gphoto, :personnal_note, :guide_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
