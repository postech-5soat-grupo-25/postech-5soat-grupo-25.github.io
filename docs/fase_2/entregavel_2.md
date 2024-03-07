---
title: Entregável 2
icon: material/file-check
---

## Kubernetes

!!! KUBERNETES "Como estamos organizando os manifestos?"

    **Kustomize** é uma ferramenta de configuração de aplicações Kubernetes que permite a personalização de recursos de configuração sem a necessidade de templates. Com Kustomize, é possível gerenciar as configurações Kubernetes de forma declarativa, utilizando arquivos YAML para definir os recursos necessários para a aplicação. O Kustomize permite a sobreposição e a composição de diferentes configurações, facilitando a reutilização e a manutenção das definições de infraestrutura. O Kustomize é integrado ao `kubectl`, permitindo o uso do comando `kubectl apply -k` para aplicar as configurações definidas com Kustomize diretamente no cluster Kubernetes.

### Manifestos

#### app-deployment

O arquivo define o Deployment da nossa aplicação Rust. O Deployment é responsável por gerenciar a criação, a atualização e a escala dos Pods que hospedam os containers da aplicação. Ele garante que o número especificado de réplicas do Pod esteja sempre em execução, facilitando a atualização e a manutenção da aplicação sem interrupções no serviço.

A configuração inclui a definição de uma única réplica do Pod, garantindo a execução de uma instância da nossa aplicação. Utilizamos a imagem Docker `brunomafra/grupo-25-tech-challenge:latest` para os containers, e a aplicação é configurada para expor a porta `3000`. As variáveis de ambiente são injetadas a partir de um ConfigMap, permitindo uma configuração externa flexível. Além disso, especificamos um pedido mínimo de `1m` de CPU para o container. Os trechos para `livenessProbe` e `readinessProbe` são preparados para monitorar a saúde do container, essenciais para garantir a disponibilidade e a confiabilidade da aplicação em produção.

#### app-hpa

O arquivo define um Horizontal Pod Autoscaler (HPA) para nossa aplicação Rust, essencial para garantir a escalabilidade e a eficiência de recursos na nossa infraestrutura Kubernetes. O HPA monitora automaticamente a utilização de recursos, como CPU, dos Pods gerenciados pelo Deployment especificado e ajusta o número de réplicas com base nas métricas observadas. Isso assegura que a aplicação possa lidar com variações na carga de trabalho, aumentando ou diminuindo o número de Pods conforme necessário, sem intervenção manual.

A configuração do HPA está direcionada ao Deployment, com o número mínimo de réplicas definido como `1` e o máximo como `10`. Isso significa que a aplicação sempre terá pelo menos um Pod em execução, podendo escalar até dez Pods com base na demanda. O critério de escalabilidade é a utilização de CPU, com o HPA configurado para aumentar o número de réplicas quando a utilização média de CPU dos Pods exceder `30%`. Essa abordagem permite um balanceamento eficaz entre o desempenho da aplicação e o uso de recursos, adaptando-se dinamicamente às necessidades de carga de trabalho.

#### app-metrics

Este arquivo habilita a coleta e o fornecimento de métricas de recursos (como CPU e memória) dos Pods e nós no nosso cluster Kubernetes. A configuração estabelece o Metrics Server como um agregador de métricas, que é utilizado por recursos como o Horizontal Pod Autoscaler (HPA) para tomar decisões de escalabilidade baseadas no uso de recursos.

É responsável por configurar as permissões necessárias através de `ServiceAccount`, `ClusterRoles` e `Bindings` para que o Metrics Server possa acessar e coletar métricas de recursos. Ele também define um serviço no namespace `kube-system` para expor o Metrics Server internamente no cluster, além de um Deployment que especifica a versão da imagem do Metrics Server, argumentos de inicialização para sua configuração adequada, e probes de `liveness` e `readiness` para assegurar a operação contínua e confiável do serviço. Por fim, um `APIService` é registrado, permitindo o acesso às métricas coletadas através da API do Kubernetes, facilitando a automação e o monitoramento baseados em métricas no cluster, o que é crucial para a escalabilidade e a eficiência da gestão de recursos.

#### app-svc

Este arquivo define um Service no Kubernetes para nossa aplicação Rust. O principal objetivo desse Service é fornecer um ponto de acesso estável para os Pods que executam nossa aplicação, permitindo a comunicação com a aplicação tanto internamente, dentro do cluster, quanto externamente. O Service abstrai a lógica de roteamento e permite que a aplicação seja acessada sem a necessidade de saber a localização exata dos Pods ou suas instâncias.

O Service é configurado como um `NodePort`, o que significa que ele estará acessível em uma porta específica (`31200`) em todos os nós do cluster. Isso facilita o acesso à aplicação de fora do cluster Kubernetes. O Service direciona o tráfego para os Pods que correspondem ao seletor, garantindo que as requisições sejam encaminhadas para a aplicação correta. As portas são configuradas para que o tráfego TCP na porta `3000` do nó seja direcionado para a porta `3000` do container, que é a porta em que nossa aplicação Rust está ouvindo. Essa configuração destaca a importância de definir claramente os pontos de comunicação e acesso para a aplicação dentro da infraestrutura Kubernetes, promovendo a disponibilidade e a escalabilidade da aplicação.

#### configmap

Este arquivo define um ConfigMap chamado na nossa infraestrutura Kubernetes. O ConfigMap é utilizado para armazenar configurações em formato de chave-valor, que podem ser consumidas por Pods na aplicação. O principal objetivo desse ConfigMap é fornecer uma maneira flexível e centralizada de gerenciar configurações externas para a nossa aplicação, como informações de conexão ao banco de dados e URLs de serviços externos, sem a necessidade de _hardcoding_ essas informações nos arquivos da aplicação.

#### db-postgres

O arquivo define um Pod no Kubernetes para hospedar o banco de dados PostgreSQL. O objetivo principal desse Pod é fornecer um serviço de banco de dados persistente e confiável para nossa aplicação, permitindo o armazenamento e a recuperação de dados de forma eficiente. Utilizando um Pod para o banco de dados, podemos aproveitar os recursos de orquestração do Kubernetes para gerenciar a disponibilidade e a escalabilidade do serviço de banco de dados.

O Pod é configurado para executar um único container, utilizando a imagem `m`, que é uma versão leve do PostgreSQL. O container expõe a porta `5432`, que é a porta padrão para conexões ao PostgreSQL, facilitando a comunicação com a aplicação. As configurações do banco de dados, como nome do banco, usuário e senha, são injetadas no container através de variáveis de ambiente definidas em um ConfigMap.

#### db-svc

Esse arquivo cria um Service no Kubernetes que tem como objetivo principal fornecer um ponto de acesso estável e confiável ao banco de dados PostgreSQL. O Service facilita a comunicação entre a aplicação e o banco de dados, permitindo que os componentes da aplicação se conectem ao banco de dados usando um nome de serviço fixo, independentemente das mudanças nos Pods que realmente executam o banco de dados.

O Service é configurado para expor a porta `5432`, que é a porta padrão usada pelo PostgreSQL para aceitar conexões. Ele utiliza um seletor para direcionar o tráfego para o Pod que executa o banco de dados. Essa configuração garante que qualquer componente da aplicação que precise se conectar ao banco de dados PostgreSQL possa fazê-lo através do nome do serviço, proporcionando uma maneira consistente e desacoplada de acessar o banco de dados dentro do cluster Kubernetes.

#### mock-pagamentos-pod

Este arquivo define um Pod cujo objetivo é simular um serviço de pagamentos para fins de desenvolvimento e teste da nossa aplicação. Ao utilizar um mock para o serviço de pagamentos, podemos validar a integração e o fluxo de pagamentos da aplicação sem a necessidade de interagir com um serviço de pagamentos real, facilitando o desenvolvimento e os testes em ambientes isolados ou de desenvolvimento.

O Pod é configurado para executar um único container, que utiliza a imagem `brunomafra/mock-pagamentos:latest`. Esta imagem contém a aplicação mock de pagamentos, projetada para simular as respostas e comportamentos de um serviço de pagamentos real. O container é configurado para expor a porta `9000`, que é a porta na qual o serviço mock de pagamentos aceita requisições. Através dessa configuração, outros componentes da nossa aplicação podem se conectar ao serviço mock de pagamentos usando o nome do Pod e a porta `9000`, permitindo testar o fluxo de pagamentos sem afetar sistemas de pagamento reais ou incorrer em custos.

#### mock-pagamentos-svc

Este arquivo cria um Service cujo principal objetivo é fornecer um ponto de acesso estável ao Pod que simula um serviço de pagamentos. Esse Service facilita a comunicação entre a nossa aplicação e o serviço mock de pagamentos, permitindo que a aplicação interaja com o mock como se fosse um serviço de pagamentos real, mas dentro do ambiente controlado do nosso cluster Kubernetes.

O Service é configurado para expor a porta `9000`, que é a porta na qual o serviço mock de pagamentos está ouvindo por requisições. Ele utiliza um seletor para direcionar o tráfego para o Pod correto que executa o mock de pagamentos. Essa configuração garante que qualquer componente da nossa aplicação que precise simular uma interação com um serviço de pagamentos possa fazê-lo de maneira consistente e confiável, utilizando o nome do serviço para se conectar ao mock.