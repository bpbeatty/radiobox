FROM quay.io/toolbx-images/ubuntu-toolbox:20.04
ARG GO_VER="1.19.8"
ARG GO_SHA="e1a0bf0ab18c8218805a1003fd702a41e2e807710b770e787e5979d1cf947aba"
ARG JS8_SHA="69fef6cf996649fa70d9abb16aae018d4818825d6de32715a7c32dc42db37d6f"

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="<brian@27megahertz.com>"

COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

COPY extra-packages /
RUN apt update -y && \
    apt upgrade -y && \
    grep -v '^#' /extra-packages | xargs apt install -y && \
    rm /extra-packages

WORKDIR /tmp
RUN wget --quiet --directory-prefix /tmp/go \
      https://go.dev/dl/go1.19.8.linux-amd64.tar.gz && \
    cd go && \
    if $(echo ${GO_SHA} go${GO_VER}.linux-amd64.tar.gz | sha256sum --check --status); then \
        rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.8.linux-amd64.tar.gz; \
    fi && \
    cd .. && \
    rm -rf /tmp/go && \
    /usr/local/go/bin/go install github.com/nonoo/kappanhang@latest && \
    wget --quiet --directory-prefix /tmp/js8 \
      http://files.js8call.com/2.2.0/js8call_2.2.0_20.04_amd64.deb && \
    cd js8 && \
    if $(echo ${JS8_SHA} js8call_2.2.0_20.04_amd64.deb | sha256sum --check --status); then \
      apt install -y ./js8call_2.2.0_20.04_amd64.deb; \
    fi && \
    cd .. && \
    rm -rf /tmp/js8

WORKDIR /

ENV PATH=$PATH:/usr/local/go/bin