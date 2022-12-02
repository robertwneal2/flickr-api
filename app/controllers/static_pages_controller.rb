class StaticPagesController < ApplicationController
  def index
    @flickr = flickr = Flickr.new ENV["flickr_key"], ENV["flickr_secret"]
  end
end
