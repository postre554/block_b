class Client < ApplicationRecord
  has_many :movies, dependent: :nullify


end
