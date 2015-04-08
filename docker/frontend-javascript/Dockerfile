FROM dockerfile/nodejs

RUN useradd -m -s /bin/zsh developer

RUN apt-get update && apt-get install -y mc git-flow git-extras curl zsh jq locales && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && echo "Europe/Bratislava" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

ADD .alias /home/developer/

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/zsh" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN locale-gen --no-purge en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN npm install -g gulp webpack webpack-dev-server bower && \
    npm install -g rx

USER developer
ENV HOME /home/developer
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

