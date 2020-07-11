FROM ruby:2.7.1
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs  

RUN mkdir /BookMarks
ENV APP_ROOT /BookMarks
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
COPY . $APP_ROOT