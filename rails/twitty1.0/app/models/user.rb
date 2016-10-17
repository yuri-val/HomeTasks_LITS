class User < ApplicationRecord
  has_attached_file :avatar,
                    styles: {
                      large: "500x500>",
                      medium: "300x300>",
                      small: "150x150>",
                      thumb: "100x100>",
                      micro: "50x50>",
                     },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :twits, dependent: :destroy
  has_many :comments, dependent: :destroy
end
