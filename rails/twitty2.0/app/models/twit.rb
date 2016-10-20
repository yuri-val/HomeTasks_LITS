class Twit < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user
  has_many :comments
  #has_and_belongs_to_many :tags
end
