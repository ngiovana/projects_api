module Api
	module V1
		class AtividadesController < ApplicationController   

            # listar atividades
            def index
				atividades = Atividade.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Atividades carregadas', data: atividades}, status: :ok
			end

			# Listar atividade por ID
			def show
				atividade = Atividade.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Atividade carregada', data: atividade}, status: :ok
			end

			# Criar nova atividade
			def create
				atividade = Atividade.new(atividade_params)
				if atividade.save
					render json: {status: 'SUCCESS', message: 'Atividade salva', data: atividade}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Atividade nao salva', data: atividade}, status: :unprocessable_entity
				end
			end

			# Excluir atividade
			def destroy
				atividade = Atividade.find(params[:id])
				atividade.destroy
				render json: {status: 'SUCCESS', message: 'Atividade deletada', data: atividade}, status: :ok
			end

			# Atualizar uma atividade
			def update
				atividade = Atividade.find(params[:id])
				if atividade.update(atividade_params)
					render json: {status: 'SUCCESS', message:'Atividade atualizada', data: atividade}, status: :ok
				else
					render json: {status: 'ERROR', message:'Atividade nao atualizada', data: atividade}, status: :unprocessable_entity
				end
			end

			# Concluir uma atividade 
			def activity_done
				atividade = Atividade.find(params[:id])

				# status true significa Em Andamento
				# status false significa Concluida
				if atividade.status == true
					atividade.status = false
					if atividade.update({status: atividade.status})
						render json: {status: 'SUCCESS', message:'Atividade concluída', data: atividade}, status: :ok
					end
				else
					render json: {status: 'ERROR', message:'Atividade já concluída', data: atividade}
				end
			end
			
			private

			# Parametros aceitos
			def atividade_params
				params.permit(:titulo, :descricao, :status, :prioridade, :dt_inicial, :dt_final, :id_org, :id_proj, :id_eq)
			end
		end
	end
end