class Organizacao < ApplicationRecord
    validates :nome, presence: true
end
