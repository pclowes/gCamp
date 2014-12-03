class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}"
  end

  def member?(project)
    projects.include?(project)
  end

  def owner?(project)
    memberships.where(project_id: project, title:"Owner").present?
  end
end
