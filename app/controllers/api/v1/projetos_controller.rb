module Api
	module V1
		class ProjetosController < ApplicationController   

            # listar projetos
            def index
				projetos = Projeto.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Projetos carregados', data: projetos}, status: :ok
			end

			# Listar projeto por ID
			def show
				projeto = Projeto.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Projeto carregado', data: projeto}, status: :ok
			end

			# Criar novo projeto
			def create
				projeto = Projeto.new(projeto_params)
				if projeto.save
					render json: {status: 'SUCCESS', message: 'Projeto salvo', data: projeto}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Projeto nao salvo', data: projeto.erros}, status: :unprocessable_entity
				end
			end

			# Excluir projeto
			def destroy
				projeto = Projeto.find(params[:id])
				projeto.destroy
				render json: {status: 'SUCCESS', message: 'Projeto deletado', data: projeto}, status: :ok
			end

			# Atualizar um projeto
			def update
				projeto = Projeto.find(params[:id])
				if projeto.update(projeto_params)
					render json: {status: 'SUCCESS', message:'Projeto atualizado', data: projeto}, status: :ok
				else
					render json: {status: 'ERROR', message:'Projeto nao atualizado', data: projeto.erros}, status: :unprocessable_entity
				end
			end

			# Concluir um projeto
			def project_done
				projeto = Projeto.find(params[:id])

				atividades_do_projeto = Atividade.joins(:projeto).where(projetos: { id: projeto.id })

				todas_as_atividades_concluidas = atividades_do_projeto.all? { |atividade| atividade.status == false }

				# status true significa Em Andamento
				# status false significa Concluido
				if todas_as_atividades_concluidas && projeto.status == true
					projeto.status = false

					if projeto.update({status: projeto.status})
						render json: {status: 'SUCCESS', message:'Projeto concluído', data: projeto}, status: :ok
					end
				elsif projeto.status == false
					render json: {status: 'ERROR', message:'Projeto já concluído', data: projeto}
				else 
					render json: {status: 'ERROR', message:'Para concluir o projeto, todas as atividades do mesmo devem estar concluídas', data: projeto}
				end
			end
			
			# def rel_project_activities_by_team
			# 	atividades_por_equipe = Atividade.joins(:projeto)
            #                       .joins("INNER JOIN equipes ON projetos.id_eq = equipes.id")
            #                       .select("equipes.nome AS nome_equipe, atividades.*")
            #                       .group("equipes.id, atividades.id")

			# 	atividades_por_equipe.each do |atividade|
			# 		puts "Equipe: #{atividade.nome_equipe}"
			# 		puts "  Título: #{atividade.titulo}, Descrição: #{atividade.descricao}"
			# 	end

			# 	render json: {status: 'ERROR', message:'Para concluir o projeto, todas as atividades do mesmo devem estar concluídas', data: projeto}
			# end

			def rel_project_activities_by_team
				atividades_por_equipe = Atividade.joins(:projeto)
												  .joins("INNER JOIN equipes ON projetos.id_eq = equipes.id")
												  .select("equipes.nome AS nome_equipe, atividades.*")
												  .group("equipes.id, atividades.id")
			  
				atividades_por_equipe_hash = {}
			  
				atividades_por_equipe.each do |atividade|
				  equipe_id = atividade["id_eq"]

				  atividades_por_equipe_hash[equipe_id] ||= { equipe: atividade["nome_equipe"], atividades: [] }
				  atividades_por_equipe_hash[equipe_id][:atividades] << { 
					id: atividade["id"], 
					titulo: atividade["titulo"], 
					descricao: atividade["descricao"] 
				  }
				end
			  
				render json: { status: 'SUCCESS', message: 'Atividades por equipe', data: atividades_por_equipe_hash.values }
			  end
			
			private

			# Parametros aceitos
			def projeto_params
				params.permit(:titulo, :descricao, :status, :nivel, :prazo_inicial, :prazo_final, :id_org, :id_eq)
			end
		end
	end
end