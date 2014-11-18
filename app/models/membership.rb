class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user, uniqueness: {scope: :project, message: "has already been added"}
  validates :user, presence: true
  validates :title, presence: true
end
