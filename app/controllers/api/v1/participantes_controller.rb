module Api
	module V1
		class ParticipantesController < ApplicationController   

            # listar participantes
            def index
				participantes = Participante.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Participantes carregados', data: participantes}, status: :ok
			end

			# Listar participante por ID
			def show
				participante = Participante.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Participante carregado', data: participante}, status: :ok
			end

			# Criar novo participante
			def create
				participante = Participante.new(participante_params)
				if participante.save
					render json: {status: 'SUCCESS', message: 'Participante salvo', data: participante}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Participante nao salvo', data: participante.erros}, status: :unprocessable_entity
				end
			end

			# Excluir participante
			def destroy
				participante = Participante.find(params[:id])
				participante.destroy
				render json: {status: 'SUCCESS', message: 'Participante deletado', data: participante}, status: :ok
			end

			# Atualizar um participante
			def update
				participante = Participante.find(params[:id])
				if participante.update(participante_params)
					render json: {status: 'SUCCESS', message:'Participante atualizado', data: participante}, status: :ok
				else
					render json: {status: 'ERROR', message:'Participante nao atualizado', data: participante.erros}, status: :unprocessable_entity
				end
			end
			
			private

			# Parametros aceitos
			def participante_params
				params.permit(:nome, :email, :senha, :cargo)
			end
		end
	end
end