# Base image
FROM python:3.11-slim

# Install Python
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
COPY pyproject.toml pyproject.toml
COPY src/my_project/ src/my_project/
COPY data/ data/
COPY models/ models/

WORKDIR /
RUN pip install -r requirements.txt --no-cache-dir
RUN pip install . --no-deps --no-cache-dir

ENTRYPOINT ["python", "-u", "src/my_project/train.py"]

#docker build -f train.dockerfile . -t train:latest

# in docker command prompt: docker run --name experiment5 -v models:/models/ train:latest