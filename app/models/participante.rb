class Participante < ApplicationRecord
    validates :email, presence: true
    validates :cargo, presence: true
    validates :nome, presence: true
    validates :senha, presence: true

    has_one :organizacao
    has_many :equipe
end
