# piperun

Desafio Piperun

## injeção de dependencia
O app utiliza GetIt para injecao de dependencia, como pattern de Service Locator, devido ao Flutter nao suportar injecao via construtor sem plugins de geração de código.

## State Management
Para gerenciamento de estado, não foi necessária a utilização de um padrao mais complexo, pois as telas são de baixa complexidade e poucas atualizações de widgets únicos, embora eu tenha familiaridade com o Provider Model (nova recomendação da Google);

## APIs
Para conexao com as APIs foi utilizado o plugin DIO, para controle de tokens, encoding, e endpoints.

## Estrutura e organização de código
O app foi organizado de maneira similar ao MVVM utilizado no Xamarin:

A Pasta views contém as views (páginas e user interfaces) da aplicação, juntamente das ViewModels(controlam o estado da View, eventos (botoes, etc), e variáveis);
A Pasta services contém métodos e classes que podem ser utilizados por qualquer viewModel, como chamados de API e dialogs neste app, e em outros casos, armazenamento de configuracoes de usuarios e regras de negocio;
A pasta models contém os modelos utilizados (PODO), e seus metodos para conversao JSON (toJson e fromJson), é utilizado serialização manual, pois bibliotecas de mapeamento automatico de JSON necessitam de geracao de código e nao permitem o debug em tempo real no caso de alteracoes do app;
_shared contém a injecao de dependencia e estilos utilizado nos widgets do aplicativo

todos os views possuem um routeName, para navegação de páginas através de rotas
loginView é o route inicial do app, apos o login, homeView é configurado como rota inicial

Geralmente as views possuem 2 estados: carregando e carregado, onde é exibida uma tela de loading enquanto os dados a serem exibidos ainda nao foram completamente carregadoss
