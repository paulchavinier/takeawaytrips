class PagesController < ApplicationController
  def home
    @guide = Guide.new
  end


end
