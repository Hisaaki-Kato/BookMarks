FROM ruby:2.7.1
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       vim \
                       default-mysql-client \
                       curl \
                       gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR /BookMarks

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install -j4

ADD . /BookMarks

RUN SECRET_KEY_BASE=placeholder bundle exec rake assets:precompile RAILS_ENV="production" \
    && yarn cache clean \
    && rm -rf node_modules tmp/cache

EXPOSE 3000