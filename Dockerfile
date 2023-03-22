FROM node:14

# Install dependencies
RUN apt-get update && apt-get install -y \
    libgtk-3-dev \
    libx11-xcb-dev \
    libxtst-dev \
    libxss1 \
    libnss3 \
    libasound2 \
    xvfb \
    wget

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install ./google-chrome-stable_current_amd64.deb -y

# Set up display
ENV DISPLAY=:99

# Set up virtual framebuffer
RUN Xvfb :99 -ac &

# Set up working directory
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Start app
CMD ["npm", "start"]
