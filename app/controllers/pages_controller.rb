class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @guide = Guide.new
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
  end
end
