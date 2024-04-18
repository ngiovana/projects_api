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
			
			private

			# Parametros aceitos
			def projeto_params
				params.permit(:titulo, :descricao, :status, :nivel, :prazo_inicial, :prazo_final, :id_org, :id_eq)
			end
		end
	end
end