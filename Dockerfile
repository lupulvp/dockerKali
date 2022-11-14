FROM kalilinux/kali-rolling

ARG USERNAME
ARG PASSWORD

ENV DEBIAN_FRONTEND noninteractive
ENV DESKTOP_PKG=kali-desktop-xfce
ENV KALI_PACKAGE=core
# options: headless,arm,core,default,nethunter,large,everything,firmware,labs

RUN apt update -q --fix-missing
RUN apt upgrade -y
RUN apt -y install --no-install-recommends sudo wget curl dbus-x11 xinit ${DESKTOP_PKG}

RUN echo "#!/bin/bash" > /startkali.sh
RUN echo "/etc/init.d/ssh start" >> /startkali.sh
RUN chmod 755 /startkali.sh

RUN apt -y install --no-install-recommends kali-linux-${KALI_PACKAGE}

RUN useradd -m -s /bin/bash -G sudo ${USERNAME}
RUN echo "$USERNAME:$PASSWORD" | chpasswd

RUN apt -y install --no-install-recommends xorg xorgxrdp xrdp ; \
echo "/etc/init.d/xrdp start" >> /startkali.sh ;

RUN echo "/bin/bash" >> /startkali.sh

EXPOSE 22 3389
WORKDIR "/root"
ENTRYPOINT ["/bin/bash"]
CMD ["/startkali.sh"]