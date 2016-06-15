class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  skip_after_action :verify_authorized, only: [:home, :friendslist, :friend_guides_list]

  def home
    @guide = Guide.new
    @contact = Contact.new
  end

  def friendslist
    @friends = current_user.get_friendslist
    @users = []
    @friends.each do |friend|
      @users << User.find_by(uid: friend["id"])
    end
  end

  def friend_guides_list
    @friend = User.find_by(uid: params[:uid])
    @guides = @friend.guides
    @markersguide = Gmaps4rails.build_markers(@guides) do |guide, marker| # construction duJson pour pousser a Gplace for Rails
      marker.lat guide.latitude
      marker.lng guide.longitude
      marker.title guide.place_type
    end
  end

end
