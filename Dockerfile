FROM python:3.8-slim-buster

RUN apt-get update && apt-get install

WORKDIR /src

COPY pyproject.toml ./
RUN pip install "poetry<2"
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev --no-interaction --no-ansi

COPY mkdocs.yml ./
ADD docs docs

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]