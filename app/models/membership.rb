class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :user, :uniqueness => {scope: :project, message: "has already been added"}
  validates :user, presence: true
  validates :title, presence: true

  before_destroy :check_owners

  def owner
    project.memberships.where(title: "Owner")
  end

  def check_owners
    if owner.count == 1 && title == "Owner"
      return false
    end
  end
end
