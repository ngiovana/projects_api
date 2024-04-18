class Participante < ApplicationRecord
    validates :email, presence: true
    validates :cargo, presence: true
    validates :nome, presence: true
    validates :senha, presence: true

    belongs_to :organizacao, foreign_key: 'id_org'
    belongs_to :equipe, foreign_key: 'id_eq'
end
