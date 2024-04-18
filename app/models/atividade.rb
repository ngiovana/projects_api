class Atividade < ApplicationRecord
    validates :titulo, presence: true
    validates :prioridade, presence: true

    belongs_to :projeto, foreign_key: 'id_proj'
    belongs_to :organizacao, foreign_key: 'id_org'
    belongs_to :equipe, foreign_key: 'id_eq'
end
