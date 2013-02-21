class Topic < ActiveRecord::Base
  attr_accessible :description, :title

  validates :description, presence: true, length: {minimum: 10}
  validates :title, presence: true, length: {in: 6..30}

  def self.recent
    scoped.order(:created_at).reverse_order
  end
end
