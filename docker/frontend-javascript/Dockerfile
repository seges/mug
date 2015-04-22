FROM dockerfile/nodejs

RUN useradd -m -s /bin/zsh developer

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    sudo sh -c "echo deb http://dl.google.com/linux/chrome/deb/ stable main > /etc/apt/sources.list.d/google.list" && \
    apt-get update && apt-get install -y mc git-flow git-extras curl zsh jq locales openjdk-7-jre-headless firefox google-chrome-stable && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && echo "Europe/Bratislava" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

#ADD .alias /home/developer/
COPY home-init.d  /home/developer/

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/usr/bin/zsh" >> /etc/passwd && \
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

RUN npm install -g grunt gulp bower

USER developer
ENV HOME /home/developer
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SHELL /usr/bin/zsh

RUN curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /usr/bin/zsh

ADD entrypoint.sh /home/developer/
ADD docker-entrypoint.d/ /docker-entrypoint.d/

CMD ["sudo", "/home/developer/entrypoint.sh"]

