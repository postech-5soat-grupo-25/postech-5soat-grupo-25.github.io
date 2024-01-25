# Docs | PosTech 5SOAT • Grupo 25
## Getting Started
First you need to clone the repository:

```bash
git clone https://github.com/postech-5soat-grupo-25/postech-5soat-grupo-25.github.io.git
cd postech-5soat-grupo-25.github.io
```

### Using the Makefile
To build and serve the site using the Makefile, simply run:

```bash
make site
```

This command will build a Docker image and run a container that serves the *mkdocs-material* site, which you can access at http://localhost:8000.

### Running with Docker
Alternatively, you can build the Docker image and run the container manually:

```bash
docker build -t postech-5soat-grupo-25.github.io .
docker run --rm -it -p 8000:8000 postech-5soat-grupo-25.github.io
```