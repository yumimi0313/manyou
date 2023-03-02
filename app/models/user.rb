class User < ApplicationRecord
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum:255 }, uniqueness: true,
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum:6 }
  before_destroy :should_not_destroy_admin
  has_many :tasks, dependent: :destroy

  private
  def should_not_destroy_admin
  # 管理者権限を持つユーザーが１名かつ@userが管理者権限を持っていたら ->trueのとき、throw(:abort)でrollbackを起こす。
  throw(:abort) if User.where(admin: true).count == 1 && self.admin?
  end
end
