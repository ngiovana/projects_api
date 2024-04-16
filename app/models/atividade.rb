class Atividade < ApplicationRecord
    validates :titulo, presence: true
    validates :prioridade, presence: true
    validates :status, presence: true

    has_one :projeto
end
