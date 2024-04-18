namespace :custom do
    desc "Exibe um menu customizado no console"
    task :menu => :environment do
      puts "Bem-vindo ao Gerenciador de Projetos!"
      puts ""
      puts "Digite '0' para ver as opções disponíveis."
  
      loop do
        print "> "
        input = gets.chomp.downcase
  
        case input
        when "0"
          puts "Comandos disponíveis:"
          puts "  0 - Mostra esta lista de comandos"
          puts "  1 - Organizações"
          puts "  2 - Participantes"
          puts "  3 - Equipes"
          puts "  4 - Projetos"
          puts "  5 - Atividades"
          puts "  6 - Relatórios "
          puts "  sair - Encerra o console"
        when "sair"
          puts "Encerrando o console..."
          break
        when "1" # submenu de organizacoes
          submenu_org(input)
        when "6" #submenu de relatórios
          submenu_relatorio(input)
        else
          puts "Comando não reconhecido. Digite '0' para ver os comandos disponíveis."
        end
      end
    end

    def submenu_relatorio(input)
      puts "Submenu: Selecione um relatório para executar"
      puts "  1 - Atividades em andamento"
      puts "  2 - Atividades concluídas"
      puts "  3 - Projetos por equipe"
      puts "  4 - Andamento dos projetos da organização"
      puts "  5 - Atividades de um projeto por prioridade"
      puts "  sair - Voltar ao menu principal"

      loop do
        print "> "
        submenu_input = gets.chomp.downcase

        case submenu_input
          when "1"
            puts "Listando atividades em andamento..."
            puts "=" * 40
            
            Api::V1::OrganizacoesController.new.activities_with_true_status_by_organization_and_team(true)
            puts "=" * 40
          when "2"
            puts "Listando atividades concluídas..."
            puts "=" * 40
            
            Api::V1::OrganizacoesController.new.activities_with_false_status_by_organization_and_team(true)
            puts "=" * 40
          when "3"
            puts "Listando projetos por equipe..."
            puts "=" * 40
            
            Api::V1::OrganizacoesController.new.rel_projects_by_team_and_organization(true)
            puts "=" * 40
          when "4"
            puts "Digite o ID da organização:"
            print "> "
            id = gets.chomp

            puts "Andamento dos projetos da organização..."
            puts "=" * 40
            
            Api::V1::OrganizacoesController.new.projects_with_completion_percentage_by_organization(id, true)
            puts "=" * 40
          when "5"
            puts "Digite o Id do projeto:"
            print "> "
            id = gets.chomp

            puts "Listando atividades do projeto por prioridade..."
            puts "=" * 40
            
            Api::V1::ProjetosController.new.project_activities_ordered_by_priority(id)
            puts "=" * 40
          when "sair"
            puts "Voltando ao menu principal..."
            puts "=" * 40
            puts "Menu Principal"
            puts "-" * 40
            puts "Digite '0' para ver as opções disponíveis."
            break
          else
            puts "Comando não reconhecido. Digite 'sair' para voltar ao menu principal."
        end
    end
  end
  
    def submenu_org(input)
      puts "Submenu: Selecione uma ação do controller OrganizacoesController"
      puts "  1 - Listar todas as organizações"
      puts "  2 - Listar organização por ID"
      puts "  3 - Criar nova organização"
      puts "  4 - Excluir organização"
      puts "  5 - Atualizar uma organização"
      puts "  sair - Voltar ao menu principal"
  
      loop do
        print "> "
        submenu_input = gets.chomp.downcase
  
        case submenu_input
        when "1"
          puts "Listando todas as organizações..."
          puts "=" * 40
          
          Api::V1::OrganizacoesController.new.index(true)
          puts "=" * 40
        when "2"
          puts "Digite o ID da organização:"
          print "> "
          id = gets.chomp
          puts "Listando organização por ID..."
          puts "=" * 40
          
          Api::V1::OrganizacoesController.new.show(id)
          puts "=" * 40
        when "3"
          puts "Informe o nome da organização:"
          print "> "
          nome = gets.chomp
          puts "Informe a descrição:"
          print "> "
          descricao = gets.chomp
          params = { nome: nome, descricao: descricao }
          puts "Criando nova organização..."
          puts "=" * 40
          
          Api::V1::OrganizacoesController.new.create(params)
          puts "=" * 40
          
        when "4"
          puts "Digite o ID da organização a ser excluída:"
          print "> "
          id = gets.chomp
          puts "Excluindo organização..."
          puts "=" * 40

          Api::V1::OrganizacoesController.new.destroy(id)
          puts "=" * 40
        when "5"
          puts "Digite o ID da organização a ser atualizada:"
          print "> "
          id = gets.chomp
          puts "Informe o nome da organização:"
          print "> "
          nome = gets.chomp
          puts "Informe a descrição:"
          print "> "
          descricao = gets.chomp
          params = { id: id, nome: nome, descricao: descricao }
          puts "Atualizando organização..."
          puts "=" * 40
          
          Api::V1::OrganizacoesController.new.update(params)
          puts "=" * 40

        when "sair"
          puts "Voltando ao menu principal..."
          puts "=" * 40
          puts "Menu Principal"
          puts "-" * 40
          puts "Digite '0' para ver as opções disponíveis."
          break
        else
          puts "Comando não reconhecido. Digite 'sair' para voltar ao menu principal."
        end
      end
    end
  end