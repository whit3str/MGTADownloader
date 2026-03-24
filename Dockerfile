FROM cm2network/steamcmd:root

ENV STEAM_USERNAME=""
ENV STEAM_PASSWORD=""
ENV STEAM_GUARD_CODE=""

# Install any dependencies if needed (cm2network/steamcmd has most things)
# We run as root to avoid permission issues when writing to Docker volumes

# Prepare the download directory path inside the container
RUN mkdir -p /home/steam/Steam/steamapps/common/MTGA/MTGA_Data/Downloads/Audio

# Copy and setup the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Entrypoint is our script
CMD ["/start.sh"]
