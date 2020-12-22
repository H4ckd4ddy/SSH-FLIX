FROM python:3.7

RUN apt update;apt install -y openssh-server python3-opencv jp2a

RUN pip install opencv-python video-to-ascii

RUN mkdir -p /run/sshd

ADD sshd_config /etc/ssh/sshd_config

ADD *.sh /
RUN chmod +x /*.sh
ADD ssh-flix.jpg /

RUN useradd sshflix --shell /menu.sh;printf '%s\n' "sshflix:U6aMy0wojraho" | chpasswd -e

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]