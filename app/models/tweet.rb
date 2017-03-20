# frozen_string_literal: true
class Tweet < ApplicationRecord
  belongs_to :user
  has_attached_file :image, url: '/system/:id/:basename.:extension'

  validates_presence_of :message
  validates_length_of :message, maximum: 140

  validates_attachment_size :image, less_than: 3.megabytes
  validates_attachment_content_type :image,
                                    content_type: ['image/jpeg', 'image/png', 'image/gif', 'image/webp']

  paginates_per 5

  def post_from(user)
    self.user = user
    return unless valid?

    client = twitter_client(user.oauth_token, user.oauth_secret)
    self.uri = post_tweet(client).uri
    save
  end

  protected

  def post_tweet(client)
    media_id = client.upload(image_file) if image.present?
    client.update(message, media_ids: media_id)
  end

  def image_file
    File.open(Paperclip.io_adapters.for(image).path)
  end

  def twitter_client(oauth_token, oauth_secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
  end
end
