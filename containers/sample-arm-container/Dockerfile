FROM ubuntu:bionic

RUN groupadd -r arm-container-user -g 433
RUN useradd -u 431 -r -g arm-container-user -s /sbin/nologin -c "ARM Container image user" arm-container-user

USER root

RUN apt update -y &&\
    apt upgrade -y &&\
    apt clean && apt autoremove

USER arm-container-user

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
# CMD [ "sh", "-c", "echo", "Hello from ${USER} using CMD in Dockerfile"]

ENTRYPOINT [ "sh", "-c", "/bin/cat" ]
