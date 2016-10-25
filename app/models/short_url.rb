class ShortUrl < ActiveRecord::Base
  belongs_to :user
  has_many :short_visits, dependent: :destroy

  after_create :shortener

  has_many :short_visits, dependent: :destroy
  validates :original_url, presence: true, uniqueness: { case_sensitive: true }

  def shorty_full
  	return 'http://'+ HOSTNAME + '/' + self.shorty rescue nil
  end

  def add_vistors_count
    self.update_attributes(visits_count: (self.visits_count.nil? ? 0 : self.visits_count.to_i) + 1)
  end

  private

  def shortener
  	self.update_attributes({shorty: CommonHelper.encode("ShortUrl", self.id)})
  end
end
