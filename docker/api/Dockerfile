FROM python:3.6

RUN apt-get update \
  && apt-get install -y mecab \
  && apt-get install -y mecab-ipadic \
  && apt-get install -y libmecab-dev \
  && apt-get install -y mecab-ipadic-utf8 \
  && apt-get install -y swig

RUN mkdir /flask
WORKDIR /flask

ADD ./docker/api/requirements.txt .
ADD ./docker/api/app.py .

RUN pip install -r requirements.txt