class PrivateMessage < ApplicationRecord
    belongs_to :sender, class_name: "User"
    has_many :pm_users
    has_many :recipients, class_name: "User", through: :pm_users
end
