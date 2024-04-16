module Api
	module V1
		class OrganizacoesController < ApplicationController   

            # listar organizacoes
            def index
				organizacoes = Organizacao.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Organizacoes carregadas', data: organizacoes}, status: :ok
			end

			# Listar organizacao por ID
			def show
				organizacao = Organizacao.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Organizacao carregada', data: organizacao}, status: :ok
			end

			# Criar nova organizacao
			def create
				organizacao = Organizacao.new(organizacao_params)
				if organizacao.save
					render json: {status: 'SUCCESS', message: 'Organizacao salva', data: organizacao}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Organizacao nao salva', data: organizacao.erros}, status: :unprocessable_entity
				end
			end

			# Excluir organizacao
			def destroy
				organizacao = Organizacao.find(params[:id])
				organizacao.destroy
				render json: {status: 'SUCCESS', message: 'Organizacao deletada', data: organizacao}, status: :ok
			end

			# Atualizar uma organizacao
			def update
				organizacao = Organizacao.find(params[:id])
				if organizacao.update(organizacao_params)
					render json: {status: 'SUCCESS', message:'Organizacao atualizada', data: organizacao}, status: :ok
				else
					render json: {status: 'ERROR', message:'Organizacao nao atualizada', data: organizacao.erros}, status: :unprocessable_entity
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