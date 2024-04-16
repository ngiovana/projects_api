module Api
	module V1
		class OrganizacoesController < ApplicationController   

            # listar organizacoes
            def index
				organizacoes = Organizacao.order('created_at DESC');
				render json: {status: 'SUCCESS', message:'Organizacoes carregadas', data:organizacoes},status: :ok
			end
		end
	end
end