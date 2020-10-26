class Alchemist < ApplicationRecord
  has_secure_password
  has_many :folded_pages
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true


  def alchemy_roles # For alch
    roles
  end

  def name # For alch
    display_name || username
  end

  def alchemy_display_name # For alch
    display_name || username
  end

  def language # For alch
    alchemy_language
  end
end

