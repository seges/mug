FROM dockerfile/java:oracle-java8

RUN useradd -m -s /bin/bash developer

RUN apt-get update && apt-get install -y mc
RUN apt-get install git-flow

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer/opt && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown -R ${uid}:${gid}  /home/developer

USER developer
ENV HOME /home/developer

# Backend specific part

# scala
RUN cd /home/developer/opt && wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz 
RUN cd /home/developer/opt && tar xzf scala-2.10.4.tgz && ln -s scala-2.10.4 scala && echo "export PATH=\$PATH:/home/developer/opt/scala/bin" >> /home/developer/.bashrc

# sbt
RUN cd /home/developer/opt && wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
RUN cd /home/developer/opt && tar xzf sbt-0.13.7.tgz && ln -s sbt-0.13.7 sbt && echo "export PATH=\$PATH:/home/developer/opt/sbt/bin" >> /home/developer/.bashrc
RUN /home/developer/opt/sbt/bin/sbt about

# sbt Idea
RUN mkdir -p /home/developer/.sbt/0.13/plugins && echo "addSbtPlugin(\"com.github.mpeltonen\" % \"sbt-idea\" % \"1.6.0\")" > /home/developer/.sbt/0.13/plugins/build.sbt

# Conscript & Giter
RUN curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh
RUN echo "export PATH=\$PATH:\$HOME/bin" >> /home/developer/.bashrc
RUN /home/developer/bin/cs n8han/giter8

RUN mv /home/developer/.ivy2 /home/developer/.ivy2.tmpl

ADD entrypoint.sh /home/developer/
ADD docker-entrypoint.d/ /docker-entrypoint.d/

CMD ["sudo", "/home/developer/entrypoint.sh"]

