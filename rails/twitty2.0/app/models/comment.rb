class Comment < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :twit, required: false
end
