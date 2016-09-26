class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :cgu]
  skip_after_action :verify_authorized, only: [:home, :friendslist, :friend_guides_list, :results, :cgu]

  def home
    @guide = Guide.new
    @contact = Contact.new

    @guides = []

    # public_ids = [69, 121, 69, 121, 69, 121, 69]

    # public_ids.each do |id|
    #   if Guide.exists?(id)
    #     @guides << Guide.find(id)
    #   end
    # end

    public_ids = [409, 425, 358, 365, 353, 321, 310,  261, 263, 9, 294, 197, 327, 221, 245, 226, 198, 223, 274]

    public_ids.each do |id|
      if Guide.exists?(id)
        @guides << Guide.find(id)
      end
    end

  end

  def friendslist
    @friends = current_user.get_friendslist
    @users = []
    while @friends != nil
      @friends.each do |friend|
        @users << User.find_by(uid: friend["id"])
      end
      @friends = @friends.next_page
    end
  end

  def results
    @guides = Guide.near(params[:q], 1000).where(privacy: "public")
    @place = params[:q]
    coordinates1 = Geocoder.coordinates(params[:q])
    @near_guides = []
    @guides.each do |guide|
      coordinates2 = Geocoder.coordinates(guide.place)
      guide_distance = Geocoder::Calculations.distance_between(coordinates1, coordinates2)
      guide[:distance] = guide_distance
      @near_guides << [guide_distance, guide]
    end
    @near_guides
  end

  def cgu
  end

  # def friendslist_filtered
  #   raise
  #   @friends = current_user.get_friendslist
  #   @users = []
  #   while @friends != nil
  #     @friends.each do |friend|
  #       @users << User.find_by(uid: friend["id"])
  #     end
  #     @friends = @friends.next_page
  #   end
  #   @filtered_users = []
  #   @users.each do |user|
  #     user.guides.each do |guide|
  #       if guide.guide_country == self.guide_country
  #         @filtered_users << User.find_by(uid: user["id"])
  #       end
  #     end
  #   end
  # end

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
