FROM debian:buster-slim

# Install dependencies
RUN apt-get update && apt-get install -y midori xrdp xfce4

# Set up working directory
WORKDIR /app

# Set up xRDP
RUN echo "xfce4-session" > /etc/skel/.xsession
RUN sed -i.bak '/fi/a #xrdp multiple users configuration \n xfce4-session \n' /etc/xrdp/startwm.sh
RUN adduser xrdp ssl-cert
RUN mkdir /var/run/xrdp && chown xrdp /var/run/xrdp

# Start app
CMD ["tail", "-f", "/dev/null"]
