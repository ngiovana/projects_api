class Atividade < ApplicationRecord
    validates :titulo, presence: true
    validates :prioridade, presence: true

    belongs_to :projeto, foreign_key: 'id_proj'
end
