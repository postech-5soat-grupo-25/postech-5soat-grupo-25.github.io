---
title: Entregável 2
icon: material/file-check
---

---

!!! RUST "Qual linguagem estamos utilizando?"
    Escolhemos o **Rust** como linguagem de programação para o desenvolvimento do sistema. Essa escolha foi motivada inicialmente pelo interesse do grupo em aprender uma linguagem moderna e que tem ganhado destaque no cenário de desenvolvimento. 
    
    Rust é uma linguagem que evita erros comuns em sistemas de baixo nível e oferece ferramentas modernas para lidar com concorrência. Além disso, Rust proporciona um ambiente de desenvolvimento produtivo com um gerenciador de pacotes e um sistema de build integrados, além de uma comunidade ativa e em expansão. 
    
    Em resumo, a escolha do Rust para o desenvolvimento do sistema de autoatendimento da lanchonete se alinha com os objetivos de criar uma aplicação segura, eficiente e fácil de manter, ao mesmo tempo que proporciona uma oportunidade valiosa de aprendizado para a equipe de desenvolvimento.

---    

## Arquitetura Hegaxonal

!!! BUG ""
    A Arquitetura Hexagonal, também conhecida como _Ports & Adapters_, é um padrão de design que visa separar a lógica de negócios de uma aplicação das tecnologias utilizadas para entrar ou sair do sistema. Na Arquitetura Hexagonal, a aplicação é centralizada em torno do domínio do negócio, que é cercado por portas (_ports_) que definem os pontos de interação com serviços externos ou com o usuário. Adaptadores (_adapters_) são implementados para se conectarem a essas portas, permitindo que a aplicação se comunique com diferentes tipos de tecnologias e interfaces sem que haja impacto na lógica central do negócio.

A utilização da arquitetura hexagonal no sistema de autoatendimento oferece diversos benefícios, especialmente considerando que estamos desenvolvendo, a princípio, um backend monolítico:

- **Flexibilidade**: Permite que mudanças em tecnologias externas, como bancos de dados ou serviços de terceiros, sejam feitas com mínimo impacto na lógica central do negócio;
- **Testabilidade**: Facilita a criação de testes automatizados, pois os adapters podem ser substituídos por versões de teste que simulam comportamentos específicos;
- **Manutenibilidade**: A clareza na separação de responsabilidades torna o código mais organizado e fácil de entender, o que simplifica a manutenção e a evolução do sistema;
- **Escalabilidade**: Embora o projeto comece como um monolito, a arquitetura hexagonal permite uma transição mais suave para uma arquitetura limpa ou de microserviços no futuro.

### Estrutura de Diretórios

A estrutura de diretórios do projeto reflete a aplicação da Arquitetura Hexagonal combinada com os princípios do Domain-Driven Design. Ela foi projetada de modo a suportar a organização do código e a separação de responsabilidades.

```
├── src
│   ├── adapter
│   │   ├── api
│   │   │   └── controllers
│   │   ├── driven
│   │   └── driver
│   ├── core
│   │   ├── application
│   │   │   ├── interfaces
│   │   │   └── use_cases
│   │   └── domain
│   │       ├── entities
│   │       └── value_objects
```

- `src/`: Raiz do código fonte do projeto, onde toda a lógica da aplicação reside.
    - `adapter/`: Contém os adaptadores da Arquitetura Hexagonal, divididos em categorias:
        - `driven/`: Adapters que o domínio "dirige", como a infraestrutura de persistência e integrações com sistemas de pagamento.
        - `driver/`: Contém os adapters que iniciam ações (ou "dirigem") no domínio, como interfaces de linhas de comando.
        - `api/`: Adapters relacionados à interface de usuário, como controladores que lidam com requisições HTTP e autenticação.
    - `core/`: Núcleo do domínio da aplicação, onde a lógica de negócios é implementada seguindo os princípios do DDD:
        - `domain/`: Contém as entidades, objetos de valor e repositórios que formam o modelo de domínio.
        - `application/`: Inclui os casos de uso que orquestram o fluxo de negócios e as interfaces que definem como o domínio interage com os adaptadores.

---