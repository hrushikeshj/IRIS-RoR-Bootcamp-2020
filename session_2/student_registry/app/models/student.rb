class Student < ApplicationRecord
    validates :cgpa, numericality: {only_integer: true, less_than_or_equal_to: 10.0, greater_than_or_equal_to: 0.0}
end
