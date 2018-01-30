# This docker file will create a container using the latest official Ubuntu image
# Created by rkiles on 05/17/2017
#

FROM dtr.richard.dtcntr.net/build/alpine:latest
ARG CI_WORKDIR
ARG CI_GITURL
ARG CI_BRANCH
WORKDIR /tmp
RUN apk update
RUN apk add openssh-client git
RUN echo $CI_BRANCH
RUN echo $CI_GITURL
RUN echo $CI_WORKDIR
RUN git clone $CI_GITURL
WORKDIR $CI_WORKDIR
RUN git checkout $CI_BRANCH

FROM python:3.6-alpine
MAINTAINER Richard D Kiles <richard.kiles@docker.com>
ARG CI_WORKDIR
WORKDIR /tmp
COPY --from=0 /tmp/$CI_WORKDIR .
RUN pip install -r requirements.txt
ENV FLASK_APP /tmp/webserver.py
CMD python -m flask run --host=0.0.0.0 --port=8080
