class Equipe < ApplicationRecord
    validates :nome, presence: true
    validates :nivel, presence: true

    has_one :organizacao
    has_many :participante
    has_many :projeto
end
