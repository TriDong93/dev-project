class PagesController < ApplicationController
  def index
    @share_videos = ShareVideo.all.recent
  end
end
