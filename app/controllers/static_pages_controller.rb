class StaticPagesController < ApplicationController
  def index
    if search_params[:commit]
      @flickr = flickr = Flickr.new ENV["flickr_key"], ENV["flickr_secret"]
      if @flickr
        @flickr_id = search_params[:flickr_id]
        begin
          photos = @flickr.people.getPhotos(user_id: @flickr_id)
          @photo_urls = []
          photos.each do |photo|
            server_id = photo.server
            id = photo.id
            secret = photo.secret
            url = "https://live.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
            @photo_urls << url
          end
        rescue
          @user_not_found = true
        end
      end
    end
  end

  def search_params
    params.permit(:commit, :flickr_id)
  end
end
