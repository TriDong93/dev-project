class ShareVideo < ApplicationRecord
  YOUTUBE_REGEXP = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/

  validates :url, presence: true
  validate :youtube_url_must_be_valid

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def youtube_id
    match = YOUTUBE_REGEXP.match(url)
    if match && !match[1].blank?
      match[1]
    else
      nil
    end
  end

  private

  def youtube_url_must_be_valid
    return if url.blank? || youtube_id.present?

    errors.add(:url, 'is invalid')
  end
end
