# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

3.times  do
	Organizacao.create({
		nome: Faker::Book.title,
		descricao: Faker::Lorem.sentence
	})
end

10.times do 
	Participante.create({
		nome: Faker::Name.unique.name,
		email: Faker::Internet.email,
		senha: Faker::Internet.password,
		cargo: Faker::Number.between(from: 1, to: 3),
		id_eq: Faker::Number.between(from: 1, to: 2),
		id_org: 1
	})
end

10.times do 
	Participante.create({
		nome: Faker::Name.unique.name,
		email: Faker::Internet.email,
		senha: Faker::Internet.password,
		cargo: Faker::Number.between(from: 1, to: 3),
		id_eq: Faker::Number.between(from: 3, to: 4),
		id_org: 2
	})
end

10.times do 
	Participante.create({
		nome: Faker::Name.unique.name,
		email: Faker::Internet.email,
		senha: Faker::Internet.password,
		cargo: Faker::Number.between(from: 1, to: 3),
		id_eq: Faker::Number.between(from: 5, to: 6),
		id_org: 3
	})
end

2.times do 
	Equipe.create({
		nome: Faker::Name.unique.name,
		nivel: Faker::Number.between(from: 1, to: 3),
		id_org: 1,
	})
end

2.times do 
	Equipe.create({
		nome: Faker::Name.unique.name,
		nivel: Faker::Number.between(from: 1, to: 3),
		id_org: 2,
	})
end

2.times do 
	Equipe.create({
		nome: Faker::Name.unique.name,
		nivel: Faker::Number.between(from: 1, to: 3),
		id_org: 3,
	})
end

3.times do 
	Projeto.create({
		titulo: Faker::Name.unique.name,
		status: Faker::Number.between(from: 1, to: 2),
		nivel: Faker::Number.between(from: 1, to: 3),
		prazo_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		prazo_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_org: 1,
		id_eq: Faker::Number.between(from: 1, to: 2)
	})
end

3.times do 
	Projeto.create({
		titulo: Faker::Name.unique.name,
		status: Faker::Number.between(from: 1, to: 2),
		nivel: Faker::Number.between(from: 1, to: 3),
		prazo_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		prazo_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_org: 2,
		id_eq: Faker::Number.between(from: 3, to: 4)
	})
end

3.times do 
	Projeto.create({
		titulo: Faker::Name.unique.name,
		status: Faker::Number.between(from: 1, to: 2),
		nivel: Faker::Number.between(from: 1, to: 3),
		prazo_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		prazo_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_org: 3,
		id_eq: Faker::Number.between(from: 5, to: 6)
	})
end

10.times do 
	Atividade.create({
		titulo: Faker::Name.unique.name,
		descricao: Faker::Lorem.sentence,
		status: Faker::Number.between(from: 1, to: 2),
		prioridade: Faker::Number.between(from: 1, to: 4),
		dt_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		dt_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_proj: Faker::Number.between(from: 1, to: 3),
		id_org: 1
	})
end

10.times do 
	Atividade.create({
		titulo: Faker::Name.unique.name,
		descricao: Faker::Lorem.sentence,
		status: Faker::Number.between(from: 1, to: 2),
		prioridade: Faker::Number.between(from: 1, to: 4),
		dt_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		dt_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_proj: Faker::Number.between(from: 4, to: 6),
		id_org: 2
	})
end

10.times do 
	Atividade.create({
		titulo: Faker::Name.unique.name,
		descricao: Faker::Lorem.sentence,
		status: Faker::Number.between(from: 1, to: 2),
		prioridade: Faker::Number.between(from: 1, to: 4),
		dt_inicial: Faker::Date.between(from: 2.days.ago, to: Date.today),
		dt_final: Faker::Date.between(from: Date.today, to: 1.month.from_now),
		id_proj: Faker::Number.between(from: 7, to: 9),
		id_org: 3
	})
end
