class Tag < ApplicationRecord
  TAG_REGEX = /(?:^|\s)(?:#)([\w\-\d]+)/i

  belongs_to :note
end
