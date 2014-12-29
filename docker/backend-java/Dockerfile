FROM dockerfile/java:oracle-java8

RUN useradd -m -s /bin/bash developer

RUN apt-get update && apt-get install -y mc
RUN apt-get install git-flow

ADD .alias /home/developer/

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
RUN cd /home/developer/opt && wget http://tux.rainside.sk/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz
RUN cd /home/developer/opt && tar xzf apache-maven-3.2.5-bin.tar.gz && ln -s apache-maven-3.2.5 maven && echo "export PATH=\$PATH:/home/developer/opt/maven/bin" >> /home/developer/.bashrc

# prepare for case when maven downloads something into the repository so it does not have to do it next time
RUN mkdir -p /home/developer/.m2/repository

RUN mv /home/developer/.m2 /home/developer/.m2.tmpl

RUN echo ". /home/developer/.alias" >> /home/developer/.bashrc

ADD init.sh /home/developer/

CMD ["sudo", "/home/developer/init.sh"]

