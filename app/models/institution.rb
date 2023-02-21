class Institution < ApplicationRecord
  normalize_attribute :name, with: :downcase do |value|
    value.squish
  end
end
