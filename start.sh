#!/bin/bash

echo "Starting Magic: The Gathering Arena Downloader..."

if [ -z "$STEAM_USERNAME" ] || [ -z "$STEAM_PASSWORD" ]; then
    echo "ERROR: STEAM_USERNAME and STEAM_PASSWORD must be defined in the .env file."
    exit 1
fi

# Build login arguments
LOGIN_ARGS="+login ${STEAM_USERNAME} ${STEAM_PASSWORD}"

# If a Steam Guard code is provided, use it
if [ ! -z "$STEAM_GUARD_CODE" ]; then
    LOGIN_ARGS="${LOGIN_ARGS} ${STEAM_GUARD_CODE}"
fi

echo "Logging into Steam and downloading MTG Arena (AppID: 2141910)..."
echo "Note: If Steam Guard is active and no code provided, it will fail and send an email with a code."
echo "If this happens, put the code in STEAM_GUARD_CODE within the .env file and restart."

# Magic: The Gathering Arena is AppID 2141910
# We force platform to 'windows' because MTGA is a Windows-only game on Steam
/home/steam/steamcmd/steamcmd.sh \
    +@sSteamCmdForcePlatformType windows \
    +force_install_dir "/data" \
    ${LOGIN_ARGS} \
    +app_update 2141910 validate \
    +quit

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "Download completed successfully! The Audio folder is exposed via Docker volume."
else
    echo "SteamCMD exited with an error code: $EXIT_CODE"
fi

# Exit to let the container stop after download
exit $EXIT_CODE
