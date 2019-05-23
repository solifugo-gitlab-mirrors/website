FROM alpine:latest

ARG HUGO=hugo
ARG HUGO_VERSION=0.55.6
ARG HUGO_APK="ca-certificates openssl git"
ARG HUGO_SHA=39d3119cdb9ba5d6f1f1b43693e707937ce851791a2ea8d28003f49927c428f4
ARG HUGO_EXTENDED_APK="libc6-compat libstdc++"
ARG HUGO_EXTENDED_SHA=8962b8cdc0ca220da97293cea0bb1b31718cb4d99d0766be6865cb976b1c1805

# Install HUGO
RUN set -eux && \
    case ${HUGO} in \
      *_extended) \
        HUGO_APK="${HUGO_APK} ${HUGO_EXTENDED_APK}" \
        HUGO_SHA="${HUGO_EXTENDED_SHA}" ;; \
    esac && \
    apk add --update --no-cache ${HUGO_APK} && \
  wget -O ${HUGO_VERSION}.tar.gz https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO}_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  echo "${HUGO_SHA}  ${HUGO_VERSION}.tar.gz" | sha256sum -c && \
  tar xf ${HUGO_VERSION}.tar.gz && mv hugo* /usr/bin/hugo && \
  rm -rf  ${HUGO_VERSION}.tar.gz && \
  rm -rf /var/cache/apk/* && \
  hugo version

EXPOSE 1313

CMD ["/usr/bin/hugo"]
