# Dockerfile (pyproject.toml + uv.lock, strict locked install)
# Base image: Python slim
FROM python:3.12-slim AS build

# Copy uv binary from the official uv image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Install build‑dependencies (if any native libs are needed). If none, you can skip.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    default-libmysqlclient-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files first (for caching)
COPY pyproject.toml uv.lock /app/

# Install dependencies only (not your project) — speeds up rebuilds when code changes
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project

# Copy the rest of your application code
COPY . /app

# Now install your project and finalize environment
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked

# Optionally compile Python bytecode for performance
ENV UV_COMPILE_BYTECODE=1
RUN python -m compileall -q .

# ---- Runtime stage (optional) ----
FROM python:3.12-slim AS runtime

WORKDIR /app

# Copy built dependencies & code from build stage
COPY --from=build /app /app

# If native libs are required at runtime (e.g., mysqlclient), install them
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Create non‑root user and switch
RUN useradd -m appuser
USER appuser

EXPOSE 8000

# Run Gunicorn to serve your Django app
CMD ["gunicorn", "alx_travel_app.wsgi:application", "--bind", "0.0.0.0:8000"]


