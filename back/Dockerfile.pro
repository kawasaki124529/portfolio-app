FROM ruby:2.6.3-alpine3.10

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata mysql-dev mysql-client" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME="/app" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY Gemfile ${HOME}
COPY Gemfile.lock ${HOME}

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache ${RUNTIME_PACKAGES} && \
    apk add --update --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

COPY . ${HOME}

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s","-e", "production", "-b", "0.0.0.0"]