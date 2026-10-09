FROM debian:trixie-slim

ARG ANSIBLE_CORE_VERSION=2.21.4

# linux-image-amd64 gives libguestfs a kernel to build its appliance from.
RUN apt-get update && apt-get install --yes --no-install-recommends \
        python3 python3-venv openssh-client ca-certificates curl \
        qemu-utils libguestfs-tools linux-image-amd64 \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/ansible \
    && /opt/ansible/bin/pip install --no-cache-dir "ansible-core==${ANSIBLE_CORE_VERSION}"

COPY requirements.yml /tmp/requirements.yml
RUN /opt/ansible/bin/ansible-galaxy collection install \
        -r /tmp/requirements.yml -p /usr/share/ansible/collections \
    && rm /tmp/requirements.yml

# uid 1000 so mounted ~/.ssh keys are readable; override with --user if needed.
RUN useradd --uid 1000 --create-home --shell /bin/bash ansible

ENV PATH=/opt/ansible/bin:$PATH \
    ANSIBLE_COLLECTIONS_PATH=/usr/share/ansible/collections \
    LIBGUESTFS_BACKEND=direct

USER ansible
WORKDIR /work

CMD ["ansible", "--version"]
