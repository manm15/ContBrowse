FROM debian:stretch

# Install packages
RUN apt-get update && \
    apt-get install -y midori xserver-xephyr bash xfonts-base x11-xserver-utils x11-utils sudo

# Set up VNC
ENV DISPLAY=:1
ENV VNC_PORT=5901
ENV VNC_RESOLUTION=1024x768
RUN sudo mkdir ~/.vnc && \
    echo "password" | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd && \
    echo "#!/bin/bash\nXephyr -screen $VNC_RESOLUTION -ac $DISPLAY &\nmidori" > ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

# Expose VNC port
EXPOSE $VNC_PORT

# Start VNC server on container startup
CMD vncserver $DISPLAY -geometry $VNC_RESOLUTION -depth 24 && tail -f /dev/null
