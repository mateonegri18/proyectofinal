FROM python:3.6

# Prevents Python from writing .pyc files and buffers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# System dependencies for building and runtime (psycopg2, Pillow, reportlab)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev \
       libjpeg62-turbo-dev \
       zlib1g-dev \
       libfreetype6-dev \
       libopenjp2-7-dev \
       libtiff5-dev \
       libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies first for better layer caching
COPY requirements.txt ./
RUN pip install --upgrade pip==21.3.1 \
    && pip install -r requirements.txt

# Copy project
COPY . .

# Ensure entrypoint is executable
RUN chmod +x ./entrypoint.sh

# Expose port (Render sets $PORT, default 8000)
EXPOSE 8000

# Default envs (can be overridden in Render)
ENV PORT=8000 \
    DJANGO_SETTINGS_MODULE=api.settings

# Start via entrypoint
CMD ["./entrypoint.sh"]

