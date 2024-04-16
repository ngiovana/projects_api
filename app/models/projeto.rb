class Projeto < ApplicationRecord
    validates :titulo, presence: true
    validates :prazo_inicial, presence: true
    validates :prazo_final, presence: true
    validates :status, presence: true
    validates :nivel, presence: true

    has_one :organizacao
    has_many :equipe
end
