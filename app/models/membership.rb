class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :user, :uniqueness => {scope: :project, message: "has already been added"}
  validates :user, presence: true
  validates :title, presence: true

  before_destroy :check_owners
  before_update :check_update

  def owner
    project.memberships.where(title: "Owner")
  end

  def check_owners
    if owner.count == 1 && title == "Owner"
      # title is what the user is being set TO not what it is being set FROM
      return false
    end
  end

  def check_update
    if owner.count > 1
      return true
    elsif owner.count ==1 && title == "Member"
      return false
    end
  end

end
