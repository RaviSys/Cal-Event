class Speaker < ApplicationRecord
  belongs_to :event, optional: true
end
