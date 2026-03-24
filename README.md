# MTG Arena Audio Downloader

A lightweight Dockerized environment based on SteamCMD to automatically download and extract updates for Magic: The Gathering Arena (AppID 2141910), exposing **only** the audio files to your host machine.

## Features
- **Headless SteamCMD Integration**: Utilizes the official Linux SteamCMD base image (`cm2network/steamcmd`) configured to download Windows games.
- **Audio Extraction**: Binds a Docker volume specifically mapped to isolate the `Audio` assets of the game for immediate access on your host without maintaining the full install.
- **Persistent Sessions**: Steam Guard verification and login sessions are persisted using a dedicated named volume to avoid hitting Rate Limits on repeated runs.
- **GHCR Image**: Ready to use Docker images hosted on the GitHub Container Registry.

## Prerequisites
- Docker and Docker Compose installed.
- A Steam Account (optional: a dummy account is recommended for automated servers).

## Installation

### 1. Setup Environment
Rename the provided `.env.example` file to `.env` and fill it with your Steam credentials:
```bash
cp .env.example .env
```
Edit `.env`:
```env
STEAM_USERNAME=your_username
STEAM_PASSWORD=your_password
STEAM_GUARD_CODE=
```

### 2. Startup
Bring up the container (it will automatically pull the GHCR image):
```bash
docker compose up
```

> **Note on Steam Guard:** 
> If your account uses Steam Guard, the first run will result in an error and Steam will send an email with an access code. Once you receive it, add the code to the `STEAM_GUARD_CODE` line in your `.env` file and run `docker compose up` again.

### 3. Retrieve Audio
Once the download is complete, the `AudioOut` directory in the repository will contain the latest MTG Arena audio files.
