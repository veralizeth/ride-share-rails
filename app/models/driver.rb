class Driver < ApplicationRecord
  has_many :trips,  dependent: :nullify
end
