module Api
	module V1
		class OrganizacoesController < ApplicationController   

            # listar organizacoes
            def index(menu = '')
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
			def show(id = '')
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
			def create(params = '')
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
			def destroy(id = '')
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
			def update(menu_params = '')
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

			# Todas as atividades em andamento agrupadas por organização e equipes
			def activities_with_true_status_by_organization_and_team(menu = '')
				atividades_por_organizacao_equipe = Atividade.joins(:projeto, :equipe)
															  .where(status: true)
															  .group("atividades.id_org, atividades.id_eq")
															  .select("atividades.id_org AS organizacao_id, atividades.id_eq AS equipe_id,
																	   COUNT(atividades.id) AS total_atividades,
																	   MAX(atividades.titulo) AS titulo_atividade,
																	   MAX(equipes.nome) AS nome_equipe")
			  
				result = {}
			  
				atividades_por_organizacao_equipe.each do |atividade|
				  organizacao_id = atividade.organizacao_id
				  equipe_id = atividade.equipe_id
			  
				  result[organizacao_id] ||= {}
				  result[organizacao_id][equipe_id] ||= {
					total_atividades: atividade.total_atividades,
					atividades: []
				  }
				  result[organizacao_id][equipe_id][:atividades] << { 
					titulo: atividade.titulo_atividade,
					nome_equipe: atividade.nome_equipe
				  }
				end
			  
				if menu.present? 
					puts "Status: SUCCESS"
					puts "Message: Atividades em andamento por organização e equipe"
					puts "Data:"
					
					result.each do |organizacao_id, equipes|
						puts "Organização ID: #{organizacao_id}"
						equipes.each do |equipe_id, data|
							puts "\tEquipe ID: #{equipe_id}"
							puts "\tTotal de Atividades: #{data[:total_atividades]}"
							puts "\tAtividades:"
							data[:atividades].each do |atividade|
								puts "\t\tTitulo: #{atividade[:titulo]}"
								puts "\t\tNome da Equipe: #{atividade[:nome_equipe]}"
							end
						end
					end
				else
					render json: { status: 'SUCCESS', message: 'Atividades em andamento por organização e equipe', data: result }
				end
			end

			# Atividades finalizadas, agrupadas por organização e equipes
			def activities_with_false_status_by_organization_and_team(menu = '')
				atividades_por_organizacao_equipe = Atividade.joins(:projeto, :equipe)
															  .where(status: false)
															  .group("atividades.id_org, atividades.id_eq")
															  .select("atividades.id_org AS organizacao_id, atividades.id_eq AS equipe_id,
																	   COUNT(atividades.id) AS total_atividades,
																	   MAX(atividades.titulo) AS titulo_atividade,
																	   MAX(equipes.nome) AS nome_equipe")
			  
				result = {}
			  
				atividades_por_organizacao_equipe.each do |atividade|
				  organizacao_id = atividade.organizacao_id
				  equipe_id = atividade.equipe_id
			  
				  result[organizacao_id] ||= {}
				  result[organizacao_id][equipe_id] ||= {
					total_atividades: atividade.total_atividades,
					atividades: []
				  }
				  result[organizacao_id][equipe_id][:atividades] << { 
					titulo: atividade.titulo_atividade,
					nome_equipe: atividade.nome_equipe
				  }
				end
			  
				if menu.present? 
					puts "Status: SUCCESS"
					puts "Message: Atividades em andamento por organização e equipe"
					puts "Data:"
					
					result.each do |organizacao_id, equipes|
						puts "Organização ID: #{organizacao_id}"
						equipes.each do |equipe_id, data|
							puts "\tEquipe ID: #{equipe_id}"
							puts "\tTotal de Atividades: #{data[:total_atividades]}"
							puts "\tAtividades:"
							data[:atividades].each do |atividade|
								puts "\t\tTitulo: #{atividade[:titulo]}"
								puts "\t\tNome da Equipe: #{atividade[:nome_equipe]}"
							end
						end
					end
				else
					render json: { status: 'SUCCESS', message: 'Atividades concluídas por organização e equipe', data: result }
				end
			end

			# Andamento dos projetos
			def projects_with_completion_percentage_by_organization(menu_id = '', menu = '')
				org_id = menu_id.present? ? menu_id : params[:id]
				projects_by_team = Projeto.where(id_org: org_id)
										   .joins(:equipe)
										   .select("projetos.id AS projeto_id, projetos.titulo AS projeto_titulo,
													equipes.id AS equipe_id, equipes.nome AS equipe_nome")
										   .group_by { |projeto| [projeto.equipe_id, projeto.equipe_nome] }
			  
				result = {}
			  
				projects_by_team.each do |(equipe_id, equipe_nome), projetos|
				  result[equipe_id] ||= { equipe_id: equipe_id, equipe_nome: equipe_nome, projetos: [] }
			  
				  projetos.each do |projeto|
					count_false = Atividade.where(id_proj: projeto.projeto_id, status: false).count
					count_all = Atividade.where(id_proj: projeto.projeto_id).count
			  
					percentual_completo = count_all > 0 ? (count_false.to_f / count_all.to_f) * 100 : 0
			  
					result[equipe_id][:projetos] << { projeto_id: projeto.projeto_id, projeto_titulo: projeto.projeto_titulo, percentual_completo: percentual_completo }
				  end
				end
				
				if menu.present? 
					puts "Status: SUCCESS"
					puts "Message: Relatório de andamento dos projetos"
					puts "Data:"
					
					result.each do |equipe_id, data|
						puts "Equipe ID: #{equipe_id}, Nome: #{data[:equipe_nome]}"
						data[:projetos].each do |projeto|
							puts "\tProjeto ID: #{projeto[:projeto_id]}, Título: #{projeto[:projeto_titulo]}, Percentual Completo: #{projeto[:percentual_completo]}%"
						end
					end
				else 
					render json: { status: 'SUCCESS', message: 'Relatório de andamento dos projetos', data: result }
				end
			end
			  
			  
			# projetos por equipe
			def rel_projects_by_team_and_organization(menu = '')
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
			  
				if menu.present? 
					puts "Status: SUCCESS"
					puts "Message: Projetos por equipe e organização"
					puts "Data:"

					projetos_por_equipe_e_organizacao_hash.each do |equipe_id, organizacoes|
						organizacoes.each do |organizacao_id, data|
							puts "Equipe: #{data[:equipe]}, Organização: #{data[:organizacao]}"
							data[:projetos].each do |projeto|
								puts "\tProjeto ID: #{projeto[:id]}, Título: #{projeto[:titulo]}, Descrição: #{projeto[:descricao]}"
							end
						end
					end
				else 
					render json: { status: 'SUCCESS', message: 'Projetos por equipe e organização', data: projetos_por_equipe_e_organizacao_hash }
			  	end
			end
			
			private

			# Parametros aceitos
			def organizacao_params
				params.permit(:nome, :descricao)
			end
		end
	end
end