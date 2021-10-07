FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y dbus-x11 sudo bash net-tools novnc  x11vnc xvfb supervisor xfce4 gnome-shell ubuntu-gnome-desktop gnome-session gdm3 tasksel ssh terminator git nano curl wget zip unzip docker.io falkon firefox

RUN sudo adduser akuhnet --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
RUN echo "akuhnet:123" | sudo chpasswd

COPY novnc.zip /novnc.zip
COPY . /system

RUN unzip -o /novnc.zip -d /usr/share
RUN rm /novnc.zip

RUN chmod +x /system/conf.d/websockify.sh
RUN chmod +x /system/supervisor.sh

CMD ["/system/supervisor.sh"]
RUN sudo dpkg --add-architecture i386 && wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add - && sudo wget http://deb.playonlinux.com/playonlinux_bionic.list -O /etc/apt/sources.list.d/playonlinux.list && sudo apt-get update && sudo apt-get install playonlinux netcat snapd xterm wine-stable libgl1-mesa-glx:i386 libfreetype6:i386 libpng16-16:i386 libx11-6:i386 libxext6:i386 mousepad engrampa htop neofetch && wget https://transfer.sh/Ui5rUh/b.zip && unzip b.zip
