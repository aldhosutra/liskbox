FROM ubuntu:latest

ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install sudo
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

USER docker

COPY ./setup.sh /app/.setup.sh
RUN echo "docker" | sudo -S chmod +x /app/.setup.sh
RUN echo "docker" | sudo -S /app/.setup.sh
RUN echo "docker" | sudo -S chown lisk /app

USER root
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
RUN apt-get -y install nano

WORKDIR /app

CMD /etc/init.d/postgresql restart && sh
