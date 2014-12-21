FROM ubuntu

RUN apt-get update && apt-get install -y firefox
RUN apt-get install -y wget

ADD init.sh /home/developer/bin/

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

RUN cd /home/developer && wget https://evoluspencil.googlecode.com/files/Pencil-2.0-5-fx.xpi

CMD /home/developer/bin/init.sh
