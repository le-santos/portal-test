# Portal Solar - Dev Test

### Requisitos 

Este projeto utiliza:

- Ruby versão `2.6.3`
- Rails versão `5.2`

O arquivo `bin/setup` está configurado para instalar dependências, criar e popular o banco. 
Para instalar a aplicação:

`$ bin/setup`

### Dependências Adicionadas

- rspec-rails `4.1.0`
- factory_bot_rails 
- database_cleaner-active_record
- via_cep

### Funcionalidades implementadas

* Busca Simples: busca PowerGenerator pelo parâmentro `name`

* Busca Avançada: busca PowerGenerator pelos parâmentros `manufacurer`, `structure_type` e `price` (Combinados ou isolados)

* Calcula custo do Frete: utilizando as informações da tabela de fretes, consulta o preço para determinada localidade. A localidade é definida pelo CEP e identificada utilizando a gem `via_cep` como auxiliar.

### Testes

O sistema de buscas foi implementado com testes de navegação com Rspec e Capybara. Para rodar os testes: 

`rspec`

