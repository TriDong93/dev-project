class ShareVideosController < ApplicationController
  before_action :authenticate_user!

  def new
    @video = ShareVideo.new
  end

  def create
    @video = ShareVideo.new(user: current_user, url: params['share_video']['url'])
    if @video.save
      redirect_to root_path
    else
      render :new
    end
  end
end
