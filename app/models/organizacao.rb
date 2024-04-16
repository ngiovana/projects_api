class Organizacao < ApplicationRecord
    validates :nome, presence: true

    has_many :participante
    has_many :equipe
    has_many :projeto
end
