# syntax=docker/dockerfile:1.2
FROM --platform=linux/amd64 scratch
ADD alpine-minirootfs.tar.gz /
COPY root /root
ENV PATH=/usr/bin:/bin
ENV ENV=/root/.shinit
SHELL ["/bin/ash", "-c"]
CMD ["/bin/ash"]
