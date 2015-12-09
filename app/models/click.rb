class Click < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  attr_accessor :created_at, :updated_at
end
