# syntax=docker/dockerfile:1.2
FROM --platform=${TARGETPLATFORM} stormmq/base:latest
ARG TARGETPLATFORM
# Needed for rustc
RUN ["/sbin/apk", "add", "libgcc"]
COPY --chown=0:0 root /root

ENV HOME=/root
ENV RUSTUP_HOME=${HOME}/.rustup
ENV RUSTUP_DIST_SERVER=file://${HOME}/rust/server
ENV RUSTUP_UPDATE_ROOT=${RUSTUP_DIST_SERVER}/rustup
ENV RUSTUP_PERMIT_COPY_RENAME=1
ENV CARGO_HOME=${HOME}/.cargo
ENV PATH="${CARGO_HOME}/bin:${PATH}"
WORKDIR ${HOME}

RUN ["/root/install-rust"]

CMD ["/bin/ash"]
