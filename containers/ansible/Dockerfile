FROM ubuntu:bionic

RUN groupadd -r ansible -g 433
RUN useradd -u 431 -r -g ansible -s /sbin/nologin -c "ARM Container image user" ansible-user

RUN apt update --yes
RUN apt upgrade --yes

RUN apt install software-properties-common openssh-client --yes
RUN add-apt-repository --yes --update ppa:ansible/ansible && \
	apt install ansible -y

RUN mkdir -p /home/ansible-user/workdir
RUN chown -v -R ansible-user:ansible /home/ansible-user


USER ansible-user

WORKDIR /home/ansible-user/workdir

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
# CMD [ "sh", "-c", "echo", "Hello from ${USER} using CMD in Dockerfile"]
#

ENTRYPOINT [ "ansible" ]
CMD ["-version"]
