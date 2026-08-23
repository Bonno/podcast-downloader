FROM python:3.11-slim

ARG USER_ID=1000
ARG GROUP_ID=1000

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g ${GROUP_ID} appuser \
    && useradd -u ${USER_ID} -g appuser -m -s /bin/bash appuser

# Repository clonen
RUN git clone https://github.com/johnsosoka/rss-podcast-downloader.git .

# Python dependencies installeren
RUN pip install --no-cache-dir -r requirements.txt

RUN chown -R appuser:appuser /app
USER appuser

# Standaard entrypoint instellen op de python script
ENTRYPOINT ["python", "rss-podcast-downloader.py", "--num-episodes", "5"]
