
Bem vindo ao Loggit
=========
---

Loggit é uma aplicação para apontamento de horas em lotes no Redmine. Através algumas simples configurações você pode realizar o apontamento de hora de toda uma semana em poucos minutos!

Pré-requisitos
---

Para rodar esta aplicação você vai precisar ter instalado na sua máquina:
 - Ruby 2.0.0-p247
 - Redmine 1.2.1

Instalação
---

```sh
git clone [git-repo-url] loggit
cd loggit
bundle install
cp -r examples
```

Configuração
---
Existem 3 arquivos de são necessários para rodar a aplicação:

##### loggit.yml
Você informar a URL do servidor Redmine e a chave de acesso à api (apikey) que você pode encotrar em yourredmine.com/my/account. 

##### activities.yml
Você pode informar os tipo de atividade que o seu Redmine aceita, estas atividades estão disponíveis em yourredmine.com/enumerations.

##### project_lookup.yml
Este arquivo é simples de mapa que liga o nome que você quis dar ao projeto com o nome idêntico que o projeto tem no Redmine. É muito importante que o nome esteja indêntico ao que está no redmine.

Execução
---

A fonte de dados que é utilizada hoje é um arquivo CSV. Este arquivo deve seguir o encoding: ISO-8859-1. O formato esperado é: Horário de início atividade, Horário de conclusão da atividade, Duração, Nome do Projeto e Descrição da atividade. A linha de cabeçalho do arquivo deve ser:
```sh
Start,End,Duration,Project,Description
```
Para executar a aplicação você deve utilizar a linha de comando abaixo:

```sh
ruby lib/runner.rb report.csv
```

A aplicação irá agrupar o envio de dados por projeto, soliticando a sua confirmação, você digitar y para aceitar e n para negar o envio dos dados.

Espero ter tornado a sua vida mais facil como esta aplicação tornou a minha.

License
----

Except where otherwise noted, content on this app is licensed under a Creative Commons Attribution 4.0 International license.

**Free Software, Hell Yeah!**st