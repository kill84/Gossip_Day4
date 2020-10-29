class Tag < ApplicationRecord
    has_many :go_tags
    has_many :gossips, through: :go_tags
end
