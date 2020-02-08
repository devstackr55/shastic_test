FROM ruby:2.5.5
RUN apt-get update && apt-get install -y default-mysql-client
COPY ./docker/app/docker-entrypoint.sh /
RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .

ENTRYPOINT ["/docker-entrypoint.sh"]
