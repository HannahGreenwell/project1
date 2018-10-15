class Size < ApplicationRecord
  belongs_to :product
  enum size_type: {OS: 1, xsmall: 2, small: 3, medium: 4, large: 5}
end
