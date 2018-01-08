FROM ruby:2.5.0-slim
ENV LANG C.UTF-8

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client: In case of direct access to PostgreSQL,
#                          e.g. `rake db:structure:load` depends on psql
RUN apt-get update && \
    apt-get install -y build-essential \
                       libpq-dev \
                       postgresql-client

# Create an unprivileged user, prosaically called app, to run the app inside
# the container. If you don’t do this, then the process inside the container
# will run as root, which is against security best practices and principles.
RUN useradd --user-group \
            --create-home \
            --shell /bin/false \
            app

USER app

ENV HOME=/home/app

WORKDIR $HOME

COPY --chown=app:app . $HOME

RUN bundle install --jobs=20 \
                   --clean

EXPOSE 3000

CMD ["bundle", "exec", "puma"]
