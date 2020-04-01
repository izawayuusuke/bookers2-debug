class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,:validatable
  has_many :books, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :introduction, length: { maximum: 50 }
end
