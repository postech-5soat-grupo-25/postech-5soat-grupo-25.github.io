---
title: Entregável 2
icon: material/file-check
---

!!! RUST "Qual linguagem estamos utilizando?"
    Escolhemos o **Rust** como linguagem de programação para o desenvolvimento do sistema. Essa escolha foi motivada inicialmente pelo interesse do grupo em aprender uma linguagem moderna e que tem ganhado destaque no cenário de desenvolvimento. 
    
    Rust é uma linguagem que evita erros comuns em sistemas de baixo nível e oferece ferramentas modernas para lidar com concorrência. Além disso, Rust proporciona um ambiente de desenvolvimento produtivo com um gerenciador de pacotes e um sistema de build integrados, além de uma comunidade ativa e em expansão. 
    
    Em resumo, a escolha do Rust para o desenvolvimento do sistema de autoatendimento da lanchonete se alinha com os objetivos de criar uma aplicação segura, eficiente e fácil de manter, ao mesmo tempo que proporciona uma oportunidade valiosa de aprendizado para a equipe de desenvolvimento.

!!! POSTGRESQL "Qual banco de dados estamos utilizando?"
    Para o armazenamento de dados do nosso sistema, optamos pelo **PostgreSQL**, um sistema de gerenciamento de banco de dados relacional de código aberto. A decisão de usar o PostgreSQL foi baseada em sua robustez, confiabilidade e rica funcionalidade, que o tornam adequado para uma ampla gama de aplicações, desde pequenos projetos até soluções empresariais complexas.

    Esse banco oferece a capacidade de lidar com um volume significativo de transações e a flexibilidade para se adaptar às mudanças nos requisitos de negócios, que são requisitos fundamentais para o sucesso do projeto.

    Em resumo, o PostgreSQL se encaixa perfeitamente em nossa solução, fornecendo uma base de dados confiável e eficiente que nos permite construir um sistema de autoatendimento robusto e capaz de crescer junto com o negócio.

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
│   │   │   ├── ports
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

### Frameworks e Bibliotecas

Dentre os pacotes que estamos utilizando para a construção da aplicação, destacamos o Rocket para web e o Tokio Postgres para integração com o banco de dados. A combinação dessas ferramentas nos fornece uma base sólida e performática para estruturar a arquitetura do nosso sistema. Abaixo, elencamos mais alguns detalhes da nossa escolha.

#### Rocket

[Rocket](https://rocket.rs/) é um framework web para Rust que facilita a escrita de aplicações web rápidas e seguras sem sacrificar a flexibilidade. Ele é conhecido por sua simplicidade e ergonomia, oferecendo uma experiência de desenvolvimento agradável e produtiva. Rocket fornece uma série de funcionalidades prontas para uso, como roteamento, gerenciamento de estado, tratamento de requisições e respostas, e suporte a middlewares.

Escolhemos o Rocket para o nosso sistema de autoatendimento por várias razões:

- **Simplicidade e Expressividade**: Rocket permite definir rotas e handlers de forma declarativa, tornando o código fácil de escrever e entender;
- **Segurança**: Rocket encoraja práticas seguras de programação e gerencia muitos aspectos de segurança web automaticamente;
- **Extensibilidade**: Rocket é altamente personalizável e extensível, permitindo que a equipe adapte o framework às necessidades específicas do projeto;
- **Comunidade e Suporte**: Rocket tem uma comunidade ativa e um ecossistema crescente, com suporte a muitas crates que podem ser integradas para expandir a funcionalidade da aplicação.

#### Tokio Postgres

[Tokio Postgres](https://docs.rs/tokio-postgres/latest/tokio_postgres/) é uma biblioteca assíncrona para interação com bancos de dados PostgreSQL em Rust. Ela é construída sobre o Tokio, um runtime assíncrono para a linguagem Rust, que permite a execução de operações de entrada/saída (I/O) de forma não bloqueante e eficiente.

Optamos pelo Tokio Postgres devido às seguintes características:

- **Assincronia**: Aproveitamos o modelo assíncrono do Tokio para realizar operações de banco de dados sem bloquear a execução, melhorando a capacidade de resposta e a escalabilidade do sistema;
- **Integração com Tokio**: Como o Tokio é uma escolha comum para aplicações assíncronas em Rust, a integração com Tokio Postgres é natural e bem suportada;
- **Tipagem Forte**: A biblioteca se beneficia do sistema de tipos do Rust para garantir que as interações com o banco de dados sejam seguras e corretas em tempo de compilação.
