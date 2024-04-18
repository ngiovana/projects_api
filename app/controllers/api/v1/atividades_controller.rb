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
					render json: {status: 'ERROR', message: 'Atividade nao salva', data: atividade.erros}, status: :unprocessable_entity
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
					render json: {status: 'ERROR', message:'Atividade nao atualizada', data: atividade.erros}, status: :unprocessable_entity
				end
			end
			
			private

			# Parametros aceitos
			def atividade_params
				params.permit(:titulo, :descricao, :status, :prioridade, :dt_inicial, :dt_final, :id_org, :id_proj)
			end
		end
	end
end