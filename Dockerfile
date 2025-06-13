FROM python:3.12-slim

LABEL AUTHOR="Renan Prestes"
LABEL DESCRIPTION="Robotframework, Selenium And RequestsLib in Docker"
LABEL IMAGE_NAME="robot-image-prestes"
LABEL NAME="Docker build Robotframework for tests"


RUN mkdir -p /opt/automation
WORKDIR /opt/automation

# Update and Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    allure \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgbm1 \
    libgtk-3-dev \
    libnspr4 \
    libnss3 \
    libu2f-udev \
    libvulkan1 \
    libxcomposite1 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    libswscale-dev \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libopenjp2-7-dev \
    libavformat-dev \
    libpq-dev \
    libelf1 \
    xvfb \
    curl \
    && rm -rf /var/lib/apt/lists/*


# Install Google Chrome (most recent stable version)
RUN wget --no-verbose -O /tmp/google-chrome-stable.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_132.0.6834.159-1_amd64.deb \
    && apt install -y /tmp/google-chrome-stable.deb \
    && rm /tmp/google-chrome-stable.deb \
    && sed -i '${s/$/'" --no-sandbox --disable-dev-shm-usage"'/}' /opt/google/chrome/google-chrome

RUN pip install sbase

RUN sbase get chromedriver --path=/usr/local/bin/chromedriver \ 
    && export PATH=$PATH:usr/local/bin/chromedriver

RUN pip install --no-cache-dir \ 
    robotframework==7.1.1 \
    robotframework-seleniumlibrary \ 
    python-dotenv \ 
    robotframework-requests \ 
    robotframework-jsonlibrary

CMD ["robot", "--help"]