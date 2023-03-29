FROM debian:stretch

# Install packages
RUN apt-get update && \
    apt-get install -y midori xserver-xephyr bash xfonts-base x11-xserver-utils x11-utils sudo

# Set up VNC
ENV DISPLAY=:1
ENV VNC_PORT=5901
ENV VNC_RESOLUTION=1024x768
RUN sudo mkdir ~/.vnc && \
    sudo vncpasswd -f <<< "password\npassword\n" > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd && \
    sudo tee ~/.vnc/xstartup <<EOF >/dev/null
#!/bin/bash
Xephyr -screen $VNC_RESOLUTION -ac $DISPLAY &
midori
EOF
    RUN chmod +x ~/.vnc/xstartup

# Expose VNC port
EXPOSE $VNC_PORT

# Start VNC server on container startup
CMD vncserver $DISPLAY -geometry $VNC_RESOLUTION -depth 24 && tail -f /dev/null
