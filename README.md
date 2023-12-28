<!-- Copie este código e cole no seu README.md -->

# Store App 

  
O Store App é uma aplicação voltada para o gerenciamento de uma ampla variedade de produtos, proporcionando aos usuários a capacidade de cadastrar, editar e excluir produtos de forma intuitiva e eficiente. Com funcionalidades robustas, o aplicativo oferece uma experiência completa para organizar e acessar informações sobre os produtos de interesse.


## Funcionalidades

1.  <strong>Cadastro de Produtos:</strong>
    -   Permite aos usuários registrar detalhes completos sobre seus produtos, incluindo nome, descrição, preço e imagens associadas.
2.  <strong>Filtros e Ordenação:</strong>
    -   Oferece recursos avançados de filtragem, possibilitando aos usuários categorizar produtos por data, preço, valor mínimo e máximo. Além disso, permite a ordenação alfabética, facilitando a busca.
3.  <strong>Gestão de Imagens:</strong>
    -   Permite a associação de imagens individuais a cada produto, proporcionando uma visualização completa e detalhada dos itens cadastrados.
4.  <strong>Edição e Exclusão de Produtos:</strong>
    -   Oferece a flexibilidade de editar ou excluir informações sobre produtos já cadastrados, garantindo a manutenção de dados precisos e atualizados.
5.  <strong>Lista Atualizada de Produtos:</strong>
    -   Mantém uma lista dinâmica de produtos, proporcionando aos usuários uma visão consolidada de todos os itens cadastrados.
6.  <strong>Autenticação e Persistência de Dados:</strong>
    -   Implementa um sistema de login seguro, permitindo que o usuário acesse o aplicativo com facilidade. Após o primeiro login, o aplicativo armazena o estado de login, proporcionando uma experiência de uso contínua, sem a necessidade de login a cada acesso.

## Arquitetura

O Store App adota a arquitetura Clean Dart, uma proposta da comunidade Flutter baseada no Clean Architecture. Essa abordagem arquitetônica promove a criação de um código estruturado, modular e de fácil manutenção, proporcionando escalabilidade e testabilidade eficientes.

### Camadas da Arquitetura Clean Dart:

1.  <strong>Presentation:</strong>
    -   Responsável pela camada de apresentação da aplicação, incluindo UI, widgets, e controle de estado das telas. Aqui, o Presenter gerencia a lógica de apresentação e a comunicação com a camada de domínio.
2.  <strong>Domain:</strong>
    -   Contém as regras de negócio e a lógica de domínio da aplicação. As entidades (entities) representam objetos de domínio, e os use cases definem as operações que podem ser realizadas na aplicação.
3.  <strong>Data:</strong>
    -   Encarregada de realizar a comunicação com fontes de dados externas. Divide-se em:
        -   <strong>Datasources:</strong> Representa a origem dos dados, podendo ser APIs, banco de dados, etc.
        -   <strong>DTOs (Data Transfer Objects):</strong> Modelos utilizados para transferir dados entre camadas.
        -   <strong>Repositories:</strong> Abstrações que definem como os dados são obtidos e armazenados.

### Imagem Representativa da Arquitetura Clean Dart:

![Clean Dart Architecture](https://miro.medium.com/v2/resize:fit:1400/1*07Y2uX-7HYQa1syEzoXukA.png)

Na imagem acima, podemos visualizar a estrutura básica da arquitetura Clean Dart. Cada camada tem uma responsabilidade clara, com a seta indicando a direção permitida de dependência. Isso garante que as camadas mais internas (como Domain) não dependam das camadas mais externas (como Data).

<strong>Principais Benefícios da Arquitetura Clean Dart:</strong>

-   <strong>Modularidade:</strong> Facilita a separação de responsabilidades e a criação de módulos independentes.
-   <strong>Testabilidade:</strong> As camadas isoladas permitem testes unitários eficazes e simplificados.
-   <strong>Manutenção:</strong> A estrutura organizada facilita a identificação e correção de problemas.
-   <strong>Escalabilidade:</strong> Permite o crescimento do projeto de forma sustentável e controlada.

<h1>Principais Ferramentas Utilizadas no App</h1>

<p>O Store App utiliza uma variedade de ferramentas e serviços para oferecer uma experiência completa aos usuários. Aqui estão as principais ferramentas incorporadas no desenvolvimento do aplicativo:</p>

<h2>Firebase Authentication:</h2>

<p>O serviço de autenticação do Firebase é utilizado para permitir que os usuários realizem o cadastro e login de forma segura. Com essa ferramenta, garantimos um processo de autenticação confiável e eficiente.</p>

<h2>Firebase Firestore Database:</h2>

<p>O Firestore, também parte do ecossistema Firebase, é utilizado como banco de dados para armazenar dados relacionados aos produtos adicionados pelos usuários. Ele oferece uma solução de banco de dados NoSQL em tempo real, proporcionando agilidade e escalabilidade.</p>

<h2>Firebase Storage:</h2>

<p>Para armazenar e recuperar imagens associadas aos produtos cadastrados, utilizamos o Firebase Storage. Essa ferramenta permite o gerenciamento eficiente de recursos multimídia, contribuindo para uma experiência visual rica no aplicativo.</p>

<h2>Shared Preferences:</h2>

<p>A biblioteca Shared Preferences é empregada para o armazenamento local de dados do login do usuário. Essa ferramenta possibilita a persistência de informações essenciais, como o estado de login do usuário, mesmo após o fechamento do aplicativo.</p>

<h2>Principais Bibliotecas:</h2>

<h3>firebase_storage:</h3>

<ul>
  <li>Versão: ^11.5.6</li>
  <li>Descrição: Biblioteca para interação com o Firebase Storage, facilitando o upload e download de arquivos.</li>
</ul>

<h3>firebase_auth:</h3>

<ul>
  <li>Versão: 4.15.3</li>
  <li>Descrição: Biblioteca que fornece métodos para autenticação de usuários usando o Firebase Authentication.</li>
</ul>

<h3>shared_preferences:</h3>

<ul>
  <li>Versão: ^2.2.2</li>
  <li>Descrição: Biblioteca para persistência de dados simples chave-valor no Flutter. Utilizada para armazenar informações locais, como o estado de login.</li>
</ul>

<h3>flutter:</h3>

<ul>
  <li>Versão: sdk '>=2.0.0 <3.0.0'</li>
  <li>Descrição: Framework de desenvolvimento para criar aplicativos nativos compilados para dispositivos móveis, web e desktop a partir de uma única base de código.</li>
</ul>

<p>Essas ferramentas desempenham um papel fundamental na implementação de recursos-chave do Store App, contribuindo para a segurança, eficiência e usabilidade do aplicativo. Ao integrar essas tecnologias, buscamos oferecer uma solução completa e confiável para a gestão de produtos variados pelos usuários.</p>


## Como Executar

```bash
git clone https://github.com/seu-usuario/store-app.git
cd store-app
flutter pub get
flutter run
