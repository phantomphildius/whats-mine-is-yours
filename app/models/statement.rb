class Statement < ApplicationRecord
  belongs_to :budget

  has_many :transactions, class_name: 'StatementTransaction'
end
