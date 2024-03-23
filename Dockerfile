FROM ubuntu:20.04

# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y

# Install necessary packages for VNC server and desktop environment
RUN apt-get install -y xfce4 xfce4-goodies tightvncserver

# Create a user and switch to it
RUN useradd -ms /bin/bash vncuser && echo "vncuser:vncpassword" | chpasswd USER vncuser

# Set up the VNC server environment
RUN mkdir -p $HOME/.vnc
RUN echo "vncpassword" | vncpasswd -f > $HOME/.vnc/passwd
RUN chmod 0600 $HOME/.vnc/passwd
RUN echo "gnome-session --session=xfce" > $HOME/.vnc/xstartup
RUN chmod +x $HOME/.vnc/xstartup

# Expose port for VNC server
EXPOSE 5901

# Start the VNC server on container startup
CMD ["vncserver", "-localhost", "-geometry", "1280x800", ":1"]
