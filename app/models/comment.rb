class Comment < ApplicationRecord
  belongs_to :ticket, touch: true

  validates :text, presence: true
end
