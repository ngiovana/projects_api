class Projeto < ApplicationRecord
    validates :titulo, presence: true
    validates :prazo_inicial, presence: true
    validates :prazo_final, presence: true
    validates :status, presence: true
    validates :nivel, presence: true

    belongs_to :organizacao, foreign_key: 'id_org'
    belongs_to :equipe, foreign_key: 'id_eq'
    has_many :atividade
end
