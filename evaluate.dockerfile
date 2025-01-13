# Base image
FROM python:3.11-slim

# Install Python and dependencies
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy necessary files
COPY requirements.txt requirements.txt
COPY pyproject.toml pyproject.toml
COPY src/my_project/ src/my_project/
COPY data/ data/
COPY models/ models/

# Set the working directory
WORKDIR /

# Install Python dependencies
RUN pip install -r requirements.txt --no-cache-dir
RUN pip install . --no-deps --no-cache-dir

# Set the entry point to the evaluate script
ENTRYPOINT ["python", "-u", "src/my_project/evaluate.py"]

# run with
#docker run --name evaluate --rm \
#    -v %cd%/trained_model.pt:/models/trained_model.pt \  # mount trained model file
#    -v %cd%/data/test_images.pt:/test_images.pt \  # mount data we want to evaluate on
#    -v %cd%/data/test_targets.pt:/test_targets.pt \
#    evaluate:latest \
#    ../../models/trained_model.pt \  # argument to script, path relative to script location in container