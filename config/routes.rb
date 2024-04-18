Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace 'api' do
  	namespace 'v1' do
  		resources :organizacoes
      resources :participantes
      resources :equipes
      resources :projetos
      resources :atividades
  	end
  end

  # Defines the root path route ("/")
  root "api/v1/organizacoes#index"

  get 'api/v1/activity_done/:id', to: 'api/v1/atividades#activity_done'
  get 'api/v1/project_done/:id', to: 'api/v1/projetos#project_done'
  get 'api/v1/rel_project_activities_by_team', to: 'api/v1/projetos#rel_project_activities_by_team'
  get 'api/v1/rel_projects_by_team_and_organization', to: 'api/v1/organizacoes#rel_projects_by_team_and_organization'
  get 'api/v1/rel_activities_until_date_by_project_team_organization/:end_date', to: 'api/v1/organizacoes#rel_activities_until_date_by_project_team_organization'
end
