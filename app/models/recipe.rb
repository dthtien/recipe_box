class Recipe < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :directions
  has_many :ingredients
  
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  has_attached_file :image, styles: { original: "400x400#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :title, :description, presence: true, length: {minimum: 6}
end
