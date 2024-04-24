---
title: Terraform
icon: simple/terraform
---

# Terraform

## Infraestrutura como Código

!!! BUG ""
    O Terraform é uma poderosa ferramenta de código aberto desenvolvida pela HashiCorp, projetada para o provisionamento e gerenciamento de infraestrutura como código (IaC). Permitindo aos usuários definir infraestrutura em configurações de alto nível, usando uma linguagem de configuração declarativa, o Terraform automatiza o processo de deploy de recursos em diversos provedores de serviços em nuvem, como AWS, Google Cloud Platform e Microsoft Azure. Essa abordagem não apenas economiza tempo, mas também aumenta a eficiência, reduzindo o potencial de erros humanos.

    Um dos principais benefícios do Terraform é sua capacidade de gerenciar a infraestrutura através de código, o que facilita a replicação de ambientes, revisão de mudanças e rastreamento de estado da infraestrutura ao longo do tempo. Além disso, o Terraform promove a imutabilidade e previsibilidade nas mudanças de infraestrutura, substituindo automaticamente os recursos alterados por novos, o que contribui significativamente para a estabilidade e segurança dos ambientes de TI. Essas características tornam o Terraform uma escolha ideal para empresas que buscam adotar práticas de DevOps e automação de infraestrutura, garantindo um provisionamento consistente e confiável de recursos de TI.

    Além de sua flexibilidade e suporte multi-cloud, o Terraform se beneficia de uma comunidade ativa e um ecossistema rico, oferecendo uma vasta biblioteca de módulos reutilizáveis que aceleram o desenvolvimento de infraestrutura. Sua integração com ferramentas de CI/CD permite a automação completa do ciclo de vida da infraestrutura, desde o planejamento, criação, atualização até a destruição, tornando o Terraform uma ferramenta indispensável para a gestão moderna de infraestrutura em nuvem.

---

### Backend

Em nosso projeto, tomamos a decisão estratégica de criar um repositório dedicado para o deploy do backend do Terraform na AWS. Esta escolha foi motivada pela necessidade de uma solução robusta e escalável para o gerenciamento de nossa infraestrutura como código. Ao centralizar a configuração do backend em um repositório específico, conseguimos melhorar a segurança, a colaboração entre a equipe e a eficiência do provisionamento de recursos.

!!! GITHUB "postech-5soat-grupo-25/tech_challenge-.tfstate"
    [Acesse o repositório para mais detalhes!](https://github.com/postech-5soat-grupo-25/tech_challenge-.tfstate)

#### Amazon S3 e DynamoDB

!!! TERRAFORM "`state`"
    No Terraform, o `state` é um registro fundamental que contém informações sobre os recursos gerenciados por ele em sua infraestrutura. Este registro é crucial para o Terraform entender o que foi criado e como gerenciar mudanças na infraestrutura. O state pode ser armazenado localmente, em um arquivo chamado `terraform.tfstate`, ou remotamente, em serviços como o Amazon S3, o que facilita o compartilhamento e a colaboração em equipe. O armazenamento remoto do state também oferece benefícios adicionais, como versionamento, histórico de estados e a possibilidade de realizar backups de forma mais eficiente.

!!! TERRAFORM "`lock`"
    O `lock` do state, ou bloqueio de estado, é outro conceito importante no gerenciamento de infraestrutura com o Terraform. O bloqueio de estado previne que múltiplas pessoas ou processos modifiquem o mesmo state ao mesmo tempo, o que poderia levar a conflitos e inconsistências. Quando o state é armazenado remotamente, como em um bucket S3 com uma tabela DynamoDB para o lock no caso da AWS, o Terraform automaticamente bloqueia o state durante operações que o modificam, garantindo que apenas uma operação seja realizada por vez. Isso é essencial para manter a integridade e a consistência da infraestrutura gerenciada.

Para o armazenamento do state do Terraform, optamos pelo **Amazon S3** devido à sua confiabilidade, escalabilidade e recursos avançados de segurança, como a criptografia de objetos e o controle de acesso fino através de políticas IAM. O versionamento do bucket S3 é utilizado para manter um histórico detalhado das versões do state, permitindo uma fácil recuperação em caso de mudanças indesejadas ou erros.

Juntamente com o S3, escolhemos o **Amazon DynamoDB** para o lock do state, uma prática recomendada para equipes que trabalham em ambientes de nuvem compartilhados. O DynamoDB garante que apenas uma pessoa ou processo possa modificar o state em um dado momento, prevenindo conflitos e garantindo a integridade da nossa infraestrutura. Esta combinação de S3 para armazenamento de state e DynamoDB para lock representa uma solução de backend altamente eficaz e segura para o gerenciamento de infraestrutura com o Terraform.

#### Benefícios da Abordagem

A escolha de um repositório dedicado para o deploy do backend do Terraform, juntamente com a utilização do S3 e DynamoDB, traz uma série de benefícios para o nosso projeto:

- **Segurança Aprimorada**: A utilização de políticas IAM e criptografia AES-256 nos permite proteger nossos estados e garantir que apenas usuários autorizados tenham acesso.
- **Colaboração Eficiente**: Com o lock do state gerenciado pelo DynamoDB, nossa equipe pode trabalhar simultaneamente na infraestrutura sem risco de sobreposição ou conflitos de mudanças.
- **Recuperação e Rastreabilidade**: O versionamento do bucket S3 facilita o rastreamento de mudanças e a recuperação de versões anteriores do state, essencial para a manutenção e auditoria da infraestrutura.
- **Integração com CI/CD**: Nossa solução de backend é projetada para se integrar perfeitamente com pipelines de CI/CD, permitindo a automação do provisionamento e atualização da infraestrutura.

Para garantir a eficiência e a consistência no gerenciamento do nosso backend do Terraform, implementamos pipelines de CI/CD utilizando o GitHub Actions. Ao adotar essa abordagem, estamos não apenas otimizando o gerenciamento da nossa infraestrutura na nuvem, mas também estabelecendo uma fundação sólida para o crescimento e a escalabilidade do nosso projeto.