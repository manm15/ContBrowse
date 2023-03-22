FROM debian:buster-slim

# Install dependencies
RUN apt-get update && apt-get install -y midori

# Set up working directory
WORKDIR /app

# Start app
CMD ["midori", "-e", "Full-Screen", "-a", "https://www.google.com"]
