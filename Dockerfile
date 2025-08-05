FROM python:3.11-slim-bookworm

WORKDIR /app

# Install system dependencies needed for some Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire project into the working directory
COPY . .

# Install Python dependencies for the FastAPI application
# Ensure requirements.txt is correctly located relative to WORKDIR
RUN pip install --no-cache-dir -r src/api/requirements.txt

# Expose the port FastAPI will run on
EXPOSE 8000

# Command to run the FastAPI application directly with uvicorn
# This avoids gunicorn for simplicity in debugging
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
