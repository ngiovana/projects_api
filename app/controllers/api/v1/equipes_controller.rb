module Api
	module V1
		class EquipesController < ApplicationController   

            # listar equipes
            def index
				equipes = Equipe.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Equipes carregadas', data: equipes}, status: :ok
			end

			# Listar equipes por ID
			def show
				equipe = Equipe.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Equipe carregada', data: equipe}, status: :ok
			end

			# Criar nova equipe
			def create
				equipe = Equipe.new(equipe_params)
				if equipe.save
					render json: {status: 'SUCCESS', message: 'Equipe salva', data: equipe}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Equipe nao salva', data: equipe.erros}, status: :unprocessable_entity
				end
			end

			# Excluir equipe
			def destroy
				equipe = Equipe.find(params[:id])
				equipe.destroy
				render json: {status: 'SUCCESS', message: 'Equipe deletada', data: equipe}, status: :ok
			end

			# Atualizar uma equipe
			def update
				equipe = Equipe.find(params[:id])
				if equipe.update(equipe_params)
					render json: {status: 'SUCCESS', message:'Equipe atualizada', data: equipe}, status: :ok
				else
					render json: {status: 'ERROR', message:'Equipe nao atualizada', data: equipe.erros}, status: :unprocessable_entity
				end
			end
			
			private

			# Parametros aceitos
			def equipe_params
				params.permit(:nome, :nivel, :id_org)
			end
		end
	end
end