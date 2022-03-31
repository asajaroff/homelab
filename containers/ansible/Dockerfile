FROM ubuntu:bionic

RUN groupadd -r ansible -g 433
RUN useradd -u 431 -r -g ansible -s /sbin/nologin -c "ARM Container image user" ansible-user

RUN apt update --yes
RUN apt install software-properties-common  --yes
RUN add-apt-repository --yes --update ppa:ansible/ansible && \
	apt install ansible -y

RUN mkdir /home/ansible-user
RUN chown -v -R ansible-user:ansible /home/ansible-user


USER ansible-user

# https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
# CMD [ "sh", "-c", "echo", "Hello from ${USER} using CMD in Dockerfile"]

RUN which ansible

ENTRYPOINT [ "/usr/bin/ansible" ]
CMD ["--version"]
