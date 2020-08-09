FROM ubuntu:latest

ARG USER_ID
ARG GROUP_ID
ARG LISK_PASSWORD

ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y install sudo
RUN addgroup --gid $GROUP_ID lisk
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID lisk && usermod -a -G sudo lisk && echo "lisk:$LISK_PASSWORD" | chpasswd
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

COPY ./setup.sh /app/.setup.sh
COPY ./lisksdk.sh /app/.lisksdk.sh
RUN sudo -S chmod +x /app/.setup.sh
RUN sudo -S chmod +x /app/.lisksdk.sh
RUN sudo -S /app/.setup.sh $LISK_PASSWORD
RUN su lisk -- /app/.lisksdk.sh $LISK_PASSWORD
RUN sudo -S chown lisk /app

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
RUN apt-get -y install nano

WORKDIR /app

CMD /etc/init.d/postgresql restart && su lisk
