FROM ruby:2.5.0-slim

LABEL maintainer="Alexander Sulim <hello@sul.im>" \
      version="0.1.0"

ENV LANG C.UTF-8

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - libpq-dev: Communicate with postgres through the postgres gem
RUN apt-get update && \
    apt-get install -y build-essential \
                       libpq-dev

# Create an unprivileged user, prosaically called app, to run the app inside
# the container. If you don’t do this, then the process inside the container
# will run as root, which is against security best practices and principles.
RUN useradd --user-group \
            --create-home \
            --shell /bin/false \
            app

ENV HOME=/home/app
WORKDIR $HOME

COPY Gemfile* $HOME/
RUN bundle install --jobs=20 \
                   --clean

COPY . $HOME/

RUN SECRET_KEY_BASE=$(bin/rails secret) bin/rails assets:precompile
RUN chown -R app:app $HOME/*

USER app

EXPOSE 3000

CMD ["bundle", "exec", "puma"]
