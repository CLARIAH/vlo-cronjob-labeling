FROM python:3.12-slim
COPY --from=ghcr.io/astral-sh/uv:0.9.8 /uv /uvx /bin/

RUN apt update && apt install -y \
    curl \
    vim \
    git

WORKDIR /app
COPY .ineo.env /app/.ineo.env
COPY ineo_labeling.py /app/ineo_labeling.py
COPY ineo_labeling_utils.py /app/ineo_labeling_utils.py
COPY ineo_classes.py /app/ineo_classes.py

# Copy the project files into the working directory
COPY . /app

# Install the project's dependencies using the lockfile and settings
RUN uv sync --locked

# Reset the entrypoint, don't invoke `uv`
#CMD ["sleep", "infinity"]
CMD ["uv", "run", "/app/ineo_labeling.py"]