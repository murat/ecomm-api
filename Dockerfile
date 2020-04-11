FROM ruby:2.6.5-alpine

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  tzdata

WORKDIR /app

# Install gems
ADD Gemfile* /app/
RUN gem install bundler
RUN bundle config --global frozen 1 \
  && bundle config set without 'development test' \
  && bundle install -j $(nproc) --retry 3

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true

# Add the Rails app
ADD . /app

# Expose Puma port
EXPOSE 3000

# Start up
CMD ["bundle", "exec", "puma", "-e", "production", "-p", "3000", "-C", "config/puma.rb"]
