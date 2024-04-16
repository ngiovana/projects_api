# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

50.times  do
	Organizacao.create({
		nome: Faker::Book.title,
		descricao: Faker::Lorem.sentence
	})
end

80.times do 
	Participante.create({
		nome: Faker::Name.unique.name,
		email: Faker::Internet.email,
		senha: Faker::Internet.password,
		cargo: Faker::Number.between(from: 1, to: 3)
	})
end

40.times do 
	Equipe.create({
		nome: Faker::Name.unique.name,
		nivel: Faker::Number.between(from: 1, to: 3)
	})
end

50.times do 
	Projeto.create({
		titulo: Faker::Name.unique.name,
		status: Faker::Number.between(from: 1, to: 2),
		nivel: Faker::Number.between(from: 1, to: 3),
		prazo_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		prazo_final: Faker::Date.between(from: Date.today, to: 1.month.from_now)
	})
end

100.times do 
	Atividade.create({
		titulo: Faker::Name.unique.name,
		descricao: Faker::Lorem.sentence,
		status: Faker::Number.between(from: 1, to: 2),
		prioridade: Faker::Number.between(from: 1, to: 4),
		dt_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		dt_final: Faker::Date.between(from: Date.today, to: 1.month.from_now)
	})
end
