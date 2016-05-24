class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to card_path(@card)
    else
      render 'cards/new'
    end
  end

  def edit

  end

  def update
    @card.update(card_params)
    redirect_to @card
  end

  def show
    @card = Card.find(params[:id])
  end

  def destroy
    @card.destroy
    redirect_to :back
  end

  private

  def card_params
    params.require(:card).permit(:banner_picture, :name, :category, :formatted_address, :international_phone_number, :website, :opening_hours, :price_level, :personnal_note, :guide_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
