#!/bin/bash
#
# Server Files: /mnt/server
apt update
apt -y --no-install-recommends install curl ca-certificates unzip

cd /tmp

# Fetching latest github release
if [ -z "${RELEASE_VERSION}" ] || [ "${RELEASE_VERSION}" == "master" ]; then
        echo -e "Using latest Github Master version"
        DOWNLOAD_URL=https://github.com/jagrosh/MusicBot/releases/download/0.3.5/JMusicBot-0.3.5.jar
else
    if [ -z "${RELEASE_VERSION}" ] || [ "${RELEASE_VERSION}" == "latest" ]; then
        echo -e "Using latest release version"
        RELEASE_VERSION=$(curl -s "https://github.com/jagrosh/MusicBot/releases" | grep -o '[0-9].[0-9].[0-9]')
    fi
    DOWNLOAD_URL=https://github.com/jagrosh/MusicBot/releases/download/v${RELEASE_VERSION}/JMusicBot-${RELEASE_VERSION}.jar
fi

# Download files
cd /mnt/server
curl -LJO ${DOWNLOAD_URL}

# Creating default config
if [ ! -f /mnt/server/config.txt ]; then
    echo -e "Creating config.txt"
    cat << EOF > /mnt/server/config.txt
EOF
fi
