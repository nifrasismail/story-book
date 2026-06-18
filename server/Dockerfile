FROM python:3.12-slim

WORKDIR /app

# Install uv for fast dependency installation
RUN pip install uv

# Copy dependency files first for layer caching
COPY pyproject.toml uv.lock* ./

# Install dependencies (no dev deps, no editable install)
RUN uv pip install --system --no-cache -r pyproject.toml 2>/dev/null || \
    uv pip install --system --no-cache \
        fastapi uvicorn[standard] httpx pydantic[email] aiofiles pillow

# Copy application code
COPY routers/ ./routers/
COPY services/ ./services/
COPY models/ ./models/
COPY main.py ./

# Copy story data (read-only at runtime)
COPY data/ ./data/

# Images are served from GCS — no need to bake them into the container
RUN mkdir -p images/pages

EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
