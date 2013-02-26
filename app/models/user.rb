require 'bcrypt'

EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ 

class User < ActiveRecord::Base
  attr_accessible :email, :github, :name, :password, :password_confirmation, :username
  attr_accessor :password

  has_many :submitted_topics, class_name: 'Topic', foreign_key: 'submitter_id'
  has_many :speeches, class_name: 'Topic', foreign_key: 'speaker_id'

  validates :password, presence: true, on: :create
  validates :password, confirmation: true, length: {minimum: 6}, if: ->(u){ u.password.present? }
  validates :username, presence: true, length: {in: 2..20}, uniqueness: true

  validates :name, presence: true, on: :save
  validates :name, length: {in: 2..64}
  validates :email, presence: true, on: :save
  validates :email, length: {in: 6..64}, uniqueness: true, format: {with: EMAIL_REGEX}
  validates :github, length: {in: 1..64}

  before_save :encrypt_password

  def self.authenticate(username, password)
    return nil if username.blank? || password.blank?

    user = where(username: username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def editable_topics
    Topic.where('(topics.submitter_id = ? AND topics.speaker_id IS NULL) OR topics.speaker_id = ?', self, self)
  end

  def claimable_topics
    Topic.where(speaker_id: nil)
  end

  def can_edit_topic?(topic)
    topic.speaker == self || (topic.speaker.nil? && topic.submitter == self)
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
