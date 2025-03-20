


# Use the official Python image from the Docker Hub
FROM ghcr.io/astral-sh/uv:python3.12-alpine

#RUN apk add \
#    curl \
#    git
# Set the working directory in the container
WORKDIR /app
COPY .ineo.env /app/.ineo.env
COPY ineo_labeling.py /app/ineo_labeling.py
COPY ineo_labeling_utils.py /app/ineo_labeling_utils.py
COPY ineo_classes.py /app/ineo_classes.py
COPY requirements.txt /app/requirements.txt

# Copy the project files into the working directory
COPY . /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Install the project's dependencies using the lockfile and settings
RUN uv sync --frozen --no-dev

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH"

# Reset the entrypoint, don't invoke `uv`
ENTRYPOINT ["python", "/app/ineo_labeling.py"]