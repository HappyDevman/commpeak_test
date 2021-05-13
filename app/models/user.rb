class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: URI::MailTo::EMAIL_REGEXP

  enum role: { basic: 0, manager: 1 }
end
