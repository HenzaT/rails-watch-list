class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, through: :bookmarks, dependent: :destroy
  has_many :reviews
  has_one_attached :photo
  validates :name, presence: true
  validates :name, uniqueness: true
end
