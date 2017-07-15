class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  validates :name, presence: true

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def admin?
    self.has_role?(:admin)
  end
end
