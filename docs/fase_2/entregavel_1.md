---
title: Entregável 1
icon: material/file-check
---

## Clean Architecture e Clean Code

!!! BUG ""
    A **Clean Architecture**, proposta por Robert C. Martin (o _Uncle Bob_), é uma abordagem de design de software que visa separar as preocupações do código em camadas distintas, promovendo a independência do domínio de negócios em relação a frameworks, interfaces de usuário, e qualquer agente externo. O objetivo é criar sistemas mais maleáveis, testáveis e independentes de tecnologias externas, facilitando a manutenção e a evolução do software. O **Clean Code** é um conjunto de práticas para escrever código que seja fácil de entender e modificar. Um código limpo deve ser claro, simples, e direto, com nomes de variáveis e funções que revelam sua intenção, além de estar bem organizado e ser facilmente legível por outros desenvolvedores.

### Ports & Adapters x Clean Architecture

A Arquitetura Hexagonal (ou _Ports & Adapters_), utilizada na **Fase 1** do projeto, foca na separação da lógica de aplicação do mundo exterior, permitindo que a aplicação interaja com diferentes tecnologias de entrada e saída através de portas e adaptadores. 

Agora, a ideia é converter a aplicação para utilizar os conceitos de Clean Architecture. Ambas as arquiteturas visam a separação de preocupações e a independência de tecnologias externas. A principal diferença entre elas é que a Clean Architecture enfatiza ainda mais a separação e a independência, organizando o código em _camadas circulares_, onde as dependências apontam para dentro, em direção à lógica de negócios central. Isso promove uma maior flexibilidade e desacoplamento entre os componentes do sistema.

### Conversão para Clean Architecture

Para conversão entre as arquiteturas, atualizamos a estrutura de diretórios para refletir a separação de responsabilidades conforme os princípios da Clean Architecture:

- **Entities** (`entities`): Representam os objetos de domínio do negócio, que são independentes de qualquer framework ou banco de dados.
- **Use Cases** (`use_cases`): Contêm a lógica de negócios específica da aplicação, coordenando o fluxo de dados entre as entidades e os gateways.
- **Gateways** (`gateways`): Interfaces para comunicação com serviços externos, como bancos de dados ou serviços de pagamento.
- **Controllers** (`controllers`): Recebem requisições da interface de usuário, invocam os use cases apropriados e devolvem respostas.

Essa estrutura permite que mudanças em uma camada, como a substituição de um banco de dados ou a alteração da interface de usuário, possam ser realizadas com impacto mínimo nas outras camadas, especialmente na lógica de negócios central.

Ao adotar a Clean Architecture, o projeto se beneficia de uma maior flexibilidade, facilitando a implementação de novas funcionalidades, a manutenção do código e a realização de testes automatizados, garantindo assim a entrega contínua de valor para os usuários finais e a sustentabilidade do projeto a longo prazo.

#### Camadas da Arquitetura

##### Entidades

Na Clean Architecture, a camada de entidades é a espinha dorsal do sistema. Ela encapsula as regras de negócio do domínio, que são independentes de qualquer tecnologia externa, como bancos de dados ou interfaces de usuário. As entidades são objetos que representam conceitos do domínio do negócio, contendo tanto dados quanto as regras de negócio que governam esses dados.

As entidades estão localizadas na camada mais interna da Clean Architecture, representando o núcleo do sistema. Elas são cercadas por camadas externas que lidam com aspectos como a interface de usuário, persistência de dados e comunicação com sistemas externos, mas essas camadas dependem das entidades, e não o contrário. Isso garante que as mudanças nessas camadas externas tenham um impacto mínimo sobre as regras de negócio fundamentais do sistema.

As entidades devem ser projetadas para serem facilmente testáveis, permitindo a verificação das regras de negócio através de testes unitários. Isso é crucial para garantir a qualidade e a confiabilidade do sistema.

Uma entidade da nossa solução é definida por:

- **Atributos**: Representam as propriedades da entidade. Por exemplo, um `Pedido` pode ter atributos como _id_, _cliente_, _itens do pedido_, _status_, _data de criação_ e _data de atualização_.
- **Métodos de Negócio**: Encapsulam as regras de negócio relevantes para a entidade. Isso pode incluir validações, cálculos e operações que alteram o estado da entidade de maneira controlada.
- **Construtores**: Usados para criar instâncias da entidade, garantindo que elas estejam em um estado válido desde o início.
- **Getters/Setters**: Métodos para acessar e modificar os atributos da entidade. Embora o acesso direto aos atributos possa ser permitido em algumas linguagens, o uso de métodos permite maior controle sobre como os atributos são acessados e modificados.

Utilizamos também os seguintes princípios de design:

- **Encapsulamento**: As entidades devem gerenciar seu próprio estado através de métodos de negócio, protegendo seus atributos contra acessos e modificações indevidas.
- **Validação**: As entidades são responsáveis por validar seu estado para garantir que estejam sempre em condições válidas de acordo com as regras de negócio.
- **Independência**: As entidades não devem depender de detalhes de implementação de camadas externas, como persistência de dados ou apresentação, mantendo a pureza das regras de negócio.

##### Casos de Uso

Na Clean Architecture, a camada de Use Cases (Casos de Uso) é responsável por implementar as regras de negócio específicas da aplicação. Ela atua como intermediária entre a interface de usuário (ou qualquer outro tipo de interface externa) e o domínio do negócio, representado pelas entidades. Os Use Cases orquestram o fluxo de dados para e das entidades, e direcionam esses dados para onde eles precisam ir.

Os Use Cases estão localizados em uma camada intermediária na Clean Architecture, entre as entidades (núcleo do domínio de negócio) e os adaptadores (interfaces com o mundo externo). Eles são cruciais para garantir que as regras de negócio sejam aplicadas corretamente, independentemente de como os dados são apresentados ao usuário ou de onde eles vêm.

A camada de Use Cases é essencial para a organização e a clareza da lógica de negócio em um sistema seguindo a Clean Architecture. Ao focar nas operações que o sistema precisa realizar, sem se prender a detalhes de implementação específicos de tecnologia, os Use Cases permitem uma maior flexibilidade, manutenibilidade e escalabilidade do software.

Um caso de uso em nossa solução é definido por:

- **Entradas**: Dados necessários para executar o caso de uso. Por exemplo, os IDs necessários para criar um novo pedido.
- **Métodos**: Ações que o caso de uso pode realizar, como listar pedidos, criar um novo pedido, entre outros. Cada método implementa uma parte da lógica de negócio, manipulando uma ou mais entidades conforme necessário.

Utilizamos também os seguintes princípios de design:

- **Foco na Lógica de Negócio**: Use Cases encapsulam a lógica de negócio específica da aplicação, mantendo-a separada das preocupações de interface de usuário e persistência de dados.
- **Independência**: Use Cases são independentes de frameworks e interfaces externas, permitindo que a lógica de negócio seja reutilizada em diferentes contextos.
- **Testabilidade**: A separação clara de responsabilidades e a independência de tecnologias externas facilitam a escrita de testes unitários e de integração para os Use Cases.

##### Gateways

Na Clean Architecture, a camada de Gateways é responsável pela comunicação entre a aplicação e fontes de dados externas, como bancos de dados, APIs de terceiros, sistemas de arquivos, entre outros. Os Gateways abstraem os detalhes específicos de acesso a essas fontes de dados, permitindo que a lógica de negócio da aplicação interaja com elas de maneira agnóstica em relação à tecnologia utilizada.

Os Gateways estão localizados na camada externa da Clean Architecture, servindo como ponte entre a lógica de negócio da aplicação (Use Cases) e as fontes de dados ou serviços externos. Eles são parte dos Adapters na terminologia da Clean Architecture, adaptando a interface que a aplicação espera para a interface que os serviços externos fornecem.

A camada de Gateways é crucial para manter a flexibilidade, escalabilidade e testabilidade da aplicação. Ao encapsular os detalhes específicos de acesso a dados e fornecer uma interface limpa e abstrata para a lógica de negócio, os Gateways permitem que a aplicação evolua de forma sustentável, facilitando a manutenção e a adição de novas funcionalidades.

Um Gateway na nossa aplicação é definido por:

- **Cliente**: Uma instância do cliente de banco de dados ou serviço externo. Por exemplo, em nossa aplicação, `client` é uma instância do cliente PostgreSQL.
- **Repositórios Associados**: Referências a outros gateways ou adapters necessários para completar operações complexas que envolvem múltiplas entidades ou fontes de dados. Por exemplo, o repositório de cliente e o repositório de produto são usados para buscar informações adicionais necessárias para construir um objeto `Pedido` completo.

Utilizamos também os seguintes princípios de design:

- **Separação de Responsabilidades**: Os Gateways separam a lógica de acesso a dados da lógica de negócio, permitindo mudanças em um sem afetar o outro.
- **Abstração**: Ao abstrair os detalhes de implementação do acesso a dados, os Gateways facilitam a substituição ou modificação das fontes de dados sem impactar a aplicação.
- **Reusabilidade**: Os Gateways podem ser reutilizados em diferentes partes da aplicação, promovendo a consistência e reduzindo a duplicação de código.


##### Controllers

Na Clean Architecture, a camada de Controllers serve como um ponto de entrada para as requisições vindas de interfaces externas, como uma interface de usuário web, uma API REST, ou um terminal de linha de comando. Os Controllers interpretam as requisições, invocam os Use Cases apropriados e retornam as respostas adequadas. Eles agem como mediadores entre a interface externa e a lógica de negócio da aplicação.

Os Controllers estão localizados na camada mais externa da Clean Architecture, diretamente em contato com as interfaces de usuário ou outros sistemas externos. Eles traduzem as requisições dessas fontes em operações nos Use Cases e adaptam as respostas dos Use Cases de volta para o formato esperado pela interface externa.

A camada de Controllers é essencial para manter a interface de usuário ou API da aplicação claramente separada da lógica de negócio interna. Isso não apenas facilita a manutenção e a evolução da aplicação, mas também permite que a mesma lógica de negócio seja exposta através de múltiplas interfaces sem duplicação de código.

Um Controller em nossa aplicação é definido por:

- **Use Cases**: Referências aos Use Cases que encapsulam a lógica de negócio específica que o Controller precisa executar. No exemplo, `pedidos_e_pagamentos_use_case` e `preparacao_e_entrega_use_case` são usados para gerenciar pedidos e seus pagamentos.
- **Métodos de Ação**: Cada método no Controller corresponde a uma ação que pode ser realizada pela aplicação, como `get_pedidos`, `novo_pedido`, entre outros. Esses métodos lidam com a lógica de interação com os Use Cases e formatam as respostas para a interface externa.

Utilizamos também os seguintes princípios de design:

- **Separação de Responsabilidades**: Os Controllers separam a lógica de interação com o usuário da lógica de negócio, facilitando a manutenção e a evolução de ambos de forma independente.
- **Simplicidade**: Os Controllers devem ser simples, delegando a maior parte do trabalho pesado para os Use Cases e outros componentes da aplicação.
- **Reusabilidade**: Embora os Controllers sejam específicos para a interface que estão servindo, a lógica de negócio que eles invocam é reutilizável em diferentes contextos.



