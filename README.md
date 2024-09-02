# `docs` | PosTech 5SOAT • Grupo 25

## Como Utilizar

Primeiro, você precisa clonar o repositório:

```bash
git clone https://github.com/postech-5soat-grupo-25/postech-5soat-grupo-25.github.io.git
cd postech-5soat-grupo-25.github.io
```

### Executando com Makefile

Para construir e servir o site usando o Makefile, basta executar:

```bash
make site
```

Este comando irá construir uma imagem Docker e executar um contêiner que serve o site `mkdocs-material`, que você pode acessar em http://localhost:8000.

### Executando com Docker

Alternativamente, você pode construir a imagem Docker e executar o contêiner manualmente:

```bash
docker build -t postech-5soat-grupo-25.github.io .
docker run --rm -it -p 8000:8000 postech-5soat-grupo-25.github.io
```
