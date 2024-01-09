PROJECT=postech-5soat-grupo-25.github.io

site:
	@docker build -t $(PROJECT) .
	@docker run --rm -it -p 8000:8000 $(PROJECT)
