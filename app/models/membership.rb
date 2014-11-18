class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user, presence: true, uniqueness: true
  validates :title, presence: true
end
