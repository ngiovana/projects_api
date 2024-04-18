module Api
	module V1
		class OrganizacoesController < ApplicationController   

            # listar organizacoes
            def index(menu)
				@organizacoes = Organizacao.order('created_at DESC');

				if @organizacoes.any? && menu.present?
					puts "Lista de Organizações:"
					@organizacoes.each do |organizacao|
						puts "ID: #{organizacao.id}, Nome: #{organizacao.nome}, Descrição: #{organizacao.descricao}"
					end
				elsif @organizacoes.any?
					render json: {status: 'SUCCESS', message: 'Organizacoes carregadas', data: @organizacoes}, status: :ok
				else
					puts "Não há organizações cadastradas."
				end

			end

			# Listar organizacao por ID
			def show(id)
				organizacao = id.present? ? Organizacao.where(id: id).first : Organizacao.where(id: params[:id]).first

				if organizacao && id.present?
					puts "Organização encontrada:"
					puts "ID: #{organizacao.id}"
					puts "Nome: #{organizacao.nome}"
					puts "Descrição: #{organizacao.descricao}"
				elsif organizacao
					render json: {status: 'SUCCESS', message: 'Organizacao carregada', data: organizacao}, status: :ok
				else
					puts "Organização não encontrada."
				end
			end

			# Criar nova organizacao
			def create(params)
				organizacao = params.present? ? Organizacao.new(params) : Organizacao.new(organizacao_params)

				if params.present? && organizacao.save
					puts "Organização salva com sucesso:"
					puts "ID: #{organizacao.id}, Nome: #{organizacao.nome}, Descrição: #{organizacao.descricao}"
				elsif organizacao.save
					render json: {status: 'SUCCESS', message: 'Organizacao salva', data: organizacao}, status: :ok
				elsif params.present?
					puts "Erro ao salvar a organização:"
					puts "Mensagens de erro: #{organizacao.errors.full_messages.join(', ')}"
				else
					render json: {status: 'ERROR', message: 'Organizacao nao salva', data: organizacao.erros}, status: :unprocessable_entity
				end
			end

			# Excluir organizacao
			def destroy(id)
				organizacao = id.present? ? Organizacao.find(id) : Organizacao.find(params[:id])

				if organizacao && id.present?
					puts "Organização deletada com sucesso:"
					puts "ID: #{organizacao.id}, Nome: #{organizacao.nome}, Descrição: #{organizacao.descricao}"
				elsif organizacao
					render json: {status: 'SUCCESS', message: 'Organizacao deletada', data: organizacao}, status: :ok
				else
					puts "Organização não encontrada."
				end

				organizacao.destroy
			end

			# Atualizar uma organizacao
			def update(menu_params)
				organizacao = menu_params.present? ? Organizacao.find(menu_params[:id]) : Organizacao.find(params[:id])

				if menu_params.present? && organizacao.present? && organizacao.update({nome: menu_params[:nome], descricao: menu_params[:descricao]})
					puts "Organização atualizada com sucesso:"
					puts "ID: #{organizacao.id}, Nome: #{organizacao.nome}, Descrição: #{organizacao.descricao}"
				elsif organizacao.present? && organizacao.update(organizacao_params)
					render json: {status: 'SUCCESS', message:'Organizacao atualizada', data: organizacao}, status: :ok
				elsif menu_params.present?
					puts "Erro ao atualizar a organização:"
					puts "Mensagens de erro: #{organizacao.errors.full_messages.join(', ')}"
				else
					render json: {status: 'ERROR', message:'Organizacao nao atualizada', data: organizacao}, status: :unprocessable_entity
				end
			end

			def rel_projects_by_team_and_organization
				projetos_por_equipe_e_organizacao = Projeto.joins(:equipe, :organizacao)
															.select("equipes.nome AS nome_equipe, organizacaos.nome AS nome_organizacao, projetos.*")
			  
				# Construindo um hash para armazenar os projetos agrupados por equipe e organização
				projetos_por_equipe_e_organizacao_hash = {}
			  
				projetos_por_equipe_e_organizacao.each do |projeto|
				  equipe_id = projeto["id_eq"] # ID da equipe
				  organizacao_id = projeto["id_org"] # ID da organização
			  
				  # Adicionando o projeto à lista de projetos da equipe e organização no hash
				  projetos_por_equipe_e_organizacao_hash[equipe_id] ||= {}
				  projetos_por_equipe_e_organizacao_hash[equipe_id][organizacao_id] ||= {
					equipe: projeto["nome_equipe"],
					organizacao: projeto["nome_organizacao"],
					projetos: []
				  }
				  projetos_por_equipe_e_organizacao_hash[equipe_id][organizacao_id][:projetos] << { 
					id: projeto["id"], 
					titulo: projeto["titulo"], 
					descricao: projeto["descricao"] 
				  }
				end
			  
				render json: { status: 'SUCCESS', message: 'Projetos por equipe e organização', data: projetos_por_equipe_e_organizacao_hash }
			  end
			
			private

			# Parametros aceitos
			def organizacao_params
				params.permit(:nome, :descricao)
			end
		end
	end
end