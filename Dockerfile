FROM debian:buster-slim

# Install dependencies
RUN apt-get update && apt-get install -y dillo

# Set up working directory
WORKDIR /app

# Copy app files
COPY . .

# Start app
CMD ["dillo", "https://www.google.com"]
