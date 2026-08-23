# Podcast Downloader Docker Wrapper

A lightweight Dockerized wrapper for downloading podcasts via RSS feeds using [johnsosoka/rss-podcast-downloader](https://github.com/johnsosoka/rss-podcast-downloader). 

This setup provides an isolated, non-root Docker environment and a convenient helper script (`podcast-downloader.sh`) to download podcast episodes directly to your local file system with preserved file ownership.

---

## Features

- **Dockerized Execution**: Run the Python downloader without manually managing dependencies or Python environments.
- **Permission Friendly**: Container runs as a non-root user matching default host user permissions (`UID 1000:GID 1000`).
- **Flexible Helper Script**: Bash script handling argument validation, optional parameters, and help documentation.
- **Volume Mapping**: Automatically maps downloaded files to a local `./downloads` directory on your host machine.

---

## Prerequisites

- Docker
- Docker Compose (`docker compose` or `docker-compose`)

---

## Installation & Setup

1. Clone this repository (or copy the project files to a local directory):

2. Make the helper script executable:
   chmod +x podcast-downloader.sh

3. Build the Docker image:
   docker compose build

---

## Usage

Use the included helper script `podcast-downloader.sh` to download episodes.

### Syntax

./podcast-downloader.sh <RSS_FEED_URL> [--num-episodes <N>] [-h|--help]

### Arguments & Options

| Argument / Option | Required | Description |
| :--- | :---: | :--- |
| `<RSS_FEED_URL>` | **Yes** | The complete URL of the podcast's RSS feed. |
| `--num-episodes <N>` | No | Limit download/checking to the `<N>` most recent episodes in the feed. |
| `-h`, `--help` | No | Show the usage help menu and exit. |

---

## Examples

1. Download all episodes from an RSS feed:
   ./podcast-downloader.sh "https://feeds.example.com/podcast.xml"

2. Download only the 5 most recent episodes:
   ./podcast-downloader.sh "https://feeds.example.com/podcast.xml" --num-episodes 5

3. Display usage instructions:
   ./podcast-downloader.sh --help

---

## How It Works

1. `Dockerfile`: Builds a lightweight Python 3.11 image, creates a non-root user (`appuser` with UID `1000`), clones the original repository, and sets up the entrypoint.
2. `docker-compose.yml`: Mounts the local directory `./downloads` to `/downloads` inside the container.
3. `podcast-downloader.sh`: Validates input arguments, dynamically builds command-line options, and executes `docker compose run` targeting the container.

Downloaded files and text metadata will be stored in the `./downloads` folder on your host machine.

---

## Acknowledgments

This wrapper relies on the original Python tool created by **John Sosoka**:
- Repository: https://github.com/johnsosoka/rss-podcast-downloader

