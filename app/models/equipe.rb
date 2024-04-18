class Equipe < ApplicationRecord
    validates :nome, presence: true
    validates :nivel, presence: true

    belongs_to :organizacao, foreign_key: 'id_org'
    has_many :participante
    has_many :projeto
    has_many :atividade
end
