# syntax=docker/dockerfile:1.2
FROM --platform=${TARGETPLATFORM} stormmq/base:latest
ARG TARGETPLATFORM
COPY --chown=0:0 root /root
ENV PATH=/usr/bin:/bin:/usr/sbin:/sbin
ENV HOME=/root
ENV RUSTUP_HOME=${HOME}/.rustup
ENV RUSTUP_DIST_SERVER=file://${HOME}/rust/downloads
ENV RUSTUP_UPDATE_ROOT=${RUSTUP_DIST_SERVER}/rustup
ENV RUSTUP_PERMIT_COPY_RENAME=1
WORKDIR ${HOME}
RUN /root/install-rust
CMD ["/bin/sh"]
