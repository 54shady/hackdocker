FROM fedora:latest
RUN dnf install -y xorg-x11-server-Xspice
EXPOSE 5900/tcp
ENV DISPLAY=:1.0
CMD Xspice --port 5900 --disable-ticketing $DISPLAY  > /dev/null 2>&1 & /usr/bin/bash
