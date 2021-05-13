class Ticket < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :comments, dependent: :destroy

  after_commit :set_as_pending, if: -> { comments.empty? && resolved? }

  validates :name, :subject, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: URI::MailTo::EMAIL_REGEXP
  validate :check_status, if: -> { resolved? }

  pg_search_scope :search, against: %i[name email subject content], using: {
    tsearch: { prefix: true, any_word: true }
  }

  enum status: { initial: 0, pending: 1, resolved: 2 }

  private

  def check_status
    errors.add(:comments, "Ticket can't be resolved without any comments.") if comments.empty?
  end

  def set_as_pending
    pending!
  end
end
