class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  skip_after_action :verify_authorized, only: [:home, :friendslist, :friend_guides_list]

  def home
    @guide = Guide.new
    @contact = Contact.new

    @guides = []
    # @guides << Guide.find(69)
    # @guides << Guide.find(121)
    #     @guides << Guide.find(69)
    # @guides << Guide.find(121)
    #     @guides << Guide.find(69)
    # @guides << Guide.find(121)

    @guides << Guide.find(294)
    @guides << Guide.find(197)
    @guides << Guide.find(327)
    @guides << Guide.find(221)
    @guides << Guide.find(245)
    @guides << Guide.find(226)
    @guides << Guide.find(198)
    @guides << Guide.find(223)
    @guides << Guide.find(274)

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
