---
title: Entregável 3
icon: material/file-check
---

## Dockerfile

!!! BUG ""
    O **Dockerfile** é um script de configuração que contém uma série de instruções para criar uma imagem Docker para a aplicação. A utilização de um Dockerfile permite a automação do processo de construção da imagem, garantindo que a aplicação seja empacotada com todas as suas dependências e pronta para ser executada em qualquer ambiente Docker.

O Dockerfile cria uma imagem Docker leve e eficiente para a aplicação, utilizando a imagem `rust:1.75-alpine3.19` como base para o estágio de construção e uma imagem `scratch` para o estágio de produção.

### Estágio de Construção

- A imagem base `rust:1.75-alpine3.19` é uma versão minimalista que reduz o tamanho do container;
- O Rust é configurado para a versão `nightly` para utilizar features específicas dessa versão;
- O diretório de trabalho é definido como `/usr/src/tech-challenge`;
- A dependência `musl-dev` é instalada para permitir a compilação estática do binário;
- O código fonte é copiado para o container e o projeto é construído com `cargo build --release`.

### Estágio de Produção

- A imagem `scratch` é usada como base, que é uma imagem vazia, para manter o container o mais leve possível;
- O binário compilado é copiado do estágio de construção;
- O ponto de entrada é definido para executar o binário;
- A porta `3000` é exposta para comunicação com o container.

---

## Docker Compose

!!! BUG ""
    O **Docker Compose** define como os serviços Docker devem ser executados e como eles interagem entre si. Com o Docker Compose, podemos definir uma aplicação multi-contêiner de forma declarativa e gerenciar todo o ciclo de vida da aplicação com comandos simples.

Nosso arquivo de configuração `docker-compose.yml` define dois serviços: **app** (aplicação) e **db** (banco de dados).

### Serviço de Aplicação

- Constrói a imagem da aplicação a partir do Dockerfile descrito anteriormente;
- Reinicia automaticamente sempre que há uma falha;
- Mapeia a porta `8080` do host para a porta `3000` do container;
- Define a dependência no serviço `db`;
- Utiliza um arquivo `.env` para carregar variáveis de ambiente;
- Define variáveis de ambiente adicionais para a conexão com o banco de dados e outras configurações.

### Serviço de Banco de Dados

- Utiliza a imagem `postgres:15.2-alpine`;
- Reinicia automaticamente sempre que há uma falha;
- Define variáveis de ambiente para a configuração do PostgreSQL;
- Mapeia a porta `5432` do host para a porta `5432` do container.

---

## Tutorial para Execução da Aplicação com Docker

#### 1. Clonar o Repositório

   Faça o clone do repositório abaixo e entre no diretório do projeto:
   
   ```
   git clone git@github.com:postech-5soat-grupo-25/tech_challenge.git
   cd tech_challenge
   ```

#### 2. Construir a Imagem Docker
   
   Execute `make build` para construir a imagem Docker da aplicação. Isso também construirá a imagem do banco de dados se necessário.

#### 3. Iniciar a Aplicação
   
   Após a construção, execute `make run` para iniciar a aplicação. Isso iniciará tanto o serviço da aplicação quanto o serviço do banco de dados.

#### 4. Acessar a Aplicação
   
   Com a aplicação em execução, você pode acessá-la através do [localhost:8080](http://localhost:8080/docs/index.html) no seu navegador ou utilizando um cliente HTTP. Nessa etapa você pode interagir com a aplicação utilizando os endpoints descritos no [Entregável 2](../entregavel_2/) e acessar a Swagger UI disponibilizada.

#### 5. Desligar a Aplicação
   
   Quando terminar, execute `make down` para desligar a aplicação e remover os containers.
