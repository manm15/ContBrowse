FROM debian:stretch

# Install packages
RUN apt-get update && \
    apt-get install -y midori tigervnc-standalone-server

# Set up VNC
ENV DISPLAY=:1
ENV VNC_PORT=5901
ENV VNC_RESOLUTION=1024x768
RUN mkdir ~/.vnc && \
    echo "password" | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd && \
    echo "#!/bin/sh\nmidori &\nxterm" > ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

# Expose VNC port
EXPOSE $VNC_PORT

# Start VNC server on container startup
CMD vncserver $DISPLAY -geometry $VNC_RESOLUTION -depth 24 && tail -f /dev/null
