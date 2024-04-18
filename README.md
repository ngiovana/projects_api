# Introdução ao Domínio de Informação

A API de gerenciamento de projetos apresenta um sistema destinado a facilitar e otimizar o acompanhamento e controle de projetos em uma organização. Esse domínio de informação é essencial para empresas e equipes que buscam coordenar e supervisionar suas iniciativas de maneira eficaz, garantindo a entrega de resultados dentro do prazo e do orçamento estabelecidos.

Dentro desse contexto, a API oferece funcionalidades para lidar com áreas do gerenciamento de projetos, incluindo a criação, atualização e exclusão de projetos, atribuição de equipes, definição de prazos e acompanhamento do progresso das atividades.

A API também contém relatórios que facilitam a consulta de informações detalhadas sobre projetos, equipes e atividades.

# Esquema Conceitual
![Esquema_conceitual drawio (1)](https://github.com/ngiovana/projects_api/assets/60704988/35c3f9fa-66b0-4a10-b4d8-c0ae4df991d2)

# Esquema lógico - Dicionário de dados

**Organizacoes**(#id, nome, descricao)

| Atributo | Dominio | Tamanho | RI | Descrição |
| --- | --- | --- | --- | --- |
| id | inteiro |  | chave primária | código da organização |
| nome | texto | 30 |  | nome da organização |
| descricao | texto | 50 |  | descricao da organizacao |


**Participantes**(#id, #email, cargo, nome, senha, &id_eq, &id_org)

| Atributo | Dominio | Tamanho | RI | Descrição |
| --- | --- | --- | --- | --- |
| id | inteiro |  | chave primária | código do participante |
| cargo | inteiro |  |  | cargo/nível de acesso do participante |
| nome | texto | 30 |  | nome do participante |
| email | texto | 30 | índice único | email do participante |
| senha | texto | 10 |  | senha do participante |
| id_eq | inteiro |  | chave estrangeira para a relação com a equipe | código da equipe a qual o participante pertence |
| id_org | inteiro |  | chave estrangeira para a relação com a organização | código da organização a qual o participante pertence |


**Equipes**(#id, nome, nivel, &id_org)

| Atributo | Dominio | Tamanho | RI | Descrição |
| --- | --- | --- | --- | --- |
| id | inteiro |  | chave primária | código da equipe |
| nome | texto | 30 |  | nome da equipe |
| nivel | inteiro |  |  | nível de acesso da equipe |
| id_org | inteiro |  | chave estrangeira para a relação com a organização | código da organização a qual a equipe pertence |


**Projetos**(#id, titulo, descricao, prazo_inicial, prazo_final, status, nivel, &id_org, &id_eq)

| Atributo | Dominio | Tamanho | RI | Descrição |
| --- | --- | --- | --- | --- |
| id | inteiro |  | chave primária | código do projeto |
| titulo | texto | 30 |  | título do projeto |
| descricao | texto | 200 |  | descrição do projeto |
| prazo_inicial | data |  |  | data em que o projeto irá iniciar |
| prazo_final | data |  |  | data em que o projeto será finalizado |
| status | booleano |  |  | status do projeto (em andamento/Concluído) |
| nivel | inteiro |  |  | nível de acesso do projeto |
| id_org | inteiro |  | chave estrangeira da relação com organizações | código da organização a qual o projeto é pertencente |
| id_eq | inteiro |  | chave estrangeira da relação com equipes | código da equipe as quais estão associadas ao projeto  |


**Atividades**(#id, titulo, descricao, dt_inicial, dt_final, prioridade, status, &id_proj, &id_org, &id_eq) 

| Atributo | Dominio | Tamanho | RI | Descrição |
| --- | --- | --- | --- | --- |
| id | inteiro |  | chave primária | código da atividade |
| titulo | texto | 30 |  | título da atividade |
| descricao | texto | 200 |  | descrição da atividade |
| dt_inicial | data |  |  | data de início da atividade |
| dt_final | data |  |  | data final da atividade |
| prioridade | inteiro |  |  | nível de prioridade da atividade |
| status | booleano |  |  | status da atividade (em andamento/concluída) |
| id_proj | inteiro |  | chave estrangeira da relação com projetos | código do projeto o qual a atividade está associada |
| id_org | inteiro |  | chave estrangeira da relação com a organização | código da organização a qual a atividade está associada |
| id_eq | inteiro |  | chave estrangeira da relação com a equipe | código da equipe a qual a atividade está relacionada |

# Instruções para a execução

### Tecnologias usadas

- [Ruby on Rails](https://rubyinstaller.org/downloads)
- [PostgreSQL](https://www.postgresql.org/download/windows/)

### Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/ngiovana/projects_api.git
   ```

 2. Verifique se o Ruby está instalado
     ```bash
     ruby -v
     ```
3. Entre na pasta do projeto
   ```bash
   cd projects_api
   ```
4. Instale o Rails
   ```bash
   gem install rails
   ```
5. Instale pacotes
   ```bash
   bundle install
   ```
6. Inicie o server
   ```bash
   rails server
   ```
7. Em outro terminal, inicie o menu
   ```bash
   rails custom:menu
   ```


