# frozen_string_literal: true
class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.new(tweet_params)
    flash_options = if @tweet.post_from(current_user)
                      { success: t('.success') }
                    else
                      { danger: @tweet.errors.full_messages.first }
                    end
    redirect_to root_path, flash: flash_options
  end

  def index
    @tweet = Tweet.new
    @tweets = Tweet.where(user_id: current_user.id).
              order(created_at: :desc).
              page(params[:page])
  end

  protected

  def tweet_params
    params.require(:tweet).permit(:message, :image)
  end
end
