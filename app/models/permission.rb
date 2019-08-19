class Permission < ApplicationRecord
  belongs_to :survey
  belongs_to :user
end
