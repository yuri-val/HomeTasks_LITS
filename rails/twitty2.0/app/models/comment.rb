class Comment < ApplicationRecord
  belongs_to :twit
  belongs_to :user
end
