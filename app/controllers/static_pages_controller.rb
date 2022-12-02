class StaticPagesController < ApplicationController
  def index
    if search_params[:commit]
      @flickr_username = search_params[:flickr_username]
      if @flickr_username == ""
        @error = "Username cannot be blank"
      else
        begin
          flickr = Flickr.new ENV["flickr_key"], ENV["flickr_secret"]
          flickr_id = flickr.people.findByUsername(username: @flickr_username)["id"]
          photos = flickr.people.getPhotos(user_id: flickr_id)
          @photo_urls = []
          photos.each do |photo|
            server_id = photo.server
            id = photo.id
            secret = photo.secret
            url = "https://live.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
            @photo_urls << url
          end
        rescue
          @error = "Username not found"
        end
      end
    end
  end

  def search_params
    params.permit(:commit, :flickr_username)
  end
end
