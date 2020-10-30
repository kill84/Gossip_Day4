class User < ApplicationRecord
    validates :first_name,
    presence: true
    validates :last_name,
    presence: true
    validates :description,
    presence: true
    validates :email,
    presence: true,
    uniqueness: true
    validates :age,
    presence: true
    belongs_to :city
    has_many :gossips
    has_many :sent_messages, class_name: "PrivateMessage"
    has_many :pm_users
    has_many :received_messages, class_name: "PrivateMessage", through: :pm_users
    has_many :comments
    has_secure_password
    validates :password,
    presence: true,
    length: { minimum: 6 }
    has_many :likes

    def remember(remember_token)
      remember_digest = BCrypt::Password.create(remember_token)
      self.update(remember_digest: remember_digest)
    end
    
end
