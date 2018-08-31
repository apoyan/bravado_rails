FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y git zip

ENV APP_HOME /app
RUN mkdir $APP_HOME
RUN mkdir /bravado.shared
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

ARG BUNDLE_PATH=/box
ENV BUNDLE_PATH $BUNDLE_PATH

RUN bundle install --jobs=$(nproc)

COPY . $APP_HOME
