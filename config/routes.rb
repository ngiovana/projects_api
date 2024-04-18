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

  get 'api/v1/project_activities_ordered_by_priority/:id', to: 'api/v1/projetos#project_activities_ordered_by_priority'

  get 'api/v1/rel_projects_by_team_and_organization', to: 'api/v1/organizacoes#rel_projects_by_team_and_organization'
  get 'api/v1/activities_with_true_status_by_organization_and_team', to: 'api/v1/organizacoes#activities_with_true_status_by_organization_and_team'
  get 'api/v1/activities_with_false_status_by_organization_and_team', to: 'api/v1/organizacoes#activities_with_false_status_by_organization_and_team'
  get 'api/v1/projects_with_completion_percentage_by_organization/:id', to: 'api/v1/organizacoes#projects_with_completion_percentage_by_organization'
end
