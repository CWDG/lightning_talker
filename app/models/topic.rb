class Topic < ActiveRecord::Base
  attr_accessible :description, :title

  belongs_to :submitter, class_name: 'User', foreign_key: 'submitter_id'
  belongs_to :speaker, class_name: 'User', foreign_key: 'speaker_id'

  validates :description, presence: true, length: {minimum: 10}
  validates :submitter, presence: true
  validates :title, presence: true, length: {in: 6..30}

  def self.recent
    scoped.order(:created_at).reverse_order
  end

  def claimable?
    speaker.nil?
  end

end
