---
title: Entregável 2
icon: material/file-check
---

# Lei Geral de Proteção de Dados (LGPD)

## Solicitação de Exclusão de Dados Pessoais

??? POST "/solicitacao/exclusao/"

    Cadastra uma nova solicitação de exclusão de dados pessoais do cliente.

    | Parâmetro | Tipo     | Descrição            |
    | --------- | -------- | -------------------- |
    | nome      | `string` | Nome do cliente.     |
    | endereco  | `string` | Endereço do cliente. |
    | telefone  | `string` | Telefone do cliente. |

Decidimos criar um microserviço dedicado para gerenciar a solicitação de exclusão de dados pessoais, em vez de adicionar um endpoint ao microserviço existente de operações `usuario-cliente`. Esta decisão foi tomada com base nos seguintes argumentos:

**Isolamento de Responsabilidade**: Separar a funcionalidade de exclusão de dados pessoais da operação crítica evita que mudanças ou problemas relacionados a essa função específica afetem o funcionamento do microserviço principal de operações. Isso segue o princípio de responsabilidade única, mantendo cada serviço focado em sua função principal.

**Segurança e Conformidade**: A exclusão de dados pessoais é uma operação sensível e está diretamente relacionada à conformidade com a LGPD. Isolar essa funcionalidade em um serviço dedicado permite a aplicação de controles de segurança específicos e facilita a auditoria, sem impactar outras partes do sistema.

**Escalabilidade Independente**: Um microserviço dedicado pode ser escalado de forma independente, permitindo ajustes na capacidade de acordo com a demanda por exclusões de dados, sem afetar as operações essenciais do serviço principal.

**Facilidade de Manutenção e Evolução**: Manter a exclusão de dados em um serviço dedicado facilita sua manutenção e a implementação de futuras melhorias ou alterações na lógica de negócio, sem arriscar efeitos colaterais nas operações críticas do microserviço de operação.

**Desacoplamento de Funcionalidades**: Desacoplar a funcionalidade de exclusão de dados pessoais permite que o microserviço de operação `usuario-cliente` mantenha seu ciclo de vida independente de mudanças regulatórias ou exigências específicas relacionadas à proteção de dados.

Além dos benefícios mencionados anteriormente, a criação de um microserviço dedicado também nos proporcionou a oportunidade de explorar uma nova linguagem e tecnologia para o desenvolvimento. Em um ambiente corporativo real, é comum que diferentes times adotem stacks tecnológicas distintas, refletindo a diversidade de especializações e preferências.

!!! GITHUB "postech-5soat-grupo-25/tech-challenge-lgpd"
    [Acesse o repositório para mais detalhes!](https://github.com/postech-5soat-grupo-25/tech-challenge-lgpd)

---

## Relatório de Impacto à Proteção de Dados Pessoais (RIPD)

![Relatório de Impacto à Proteção de Dados Pessoais](../assets/content/fase_5/ripd.pdf){ type=application/pdf style="min-height:100vh;width:100%" }