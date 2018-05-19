FROM ubuntu:18.04
MAINTAINER Marcin Piechota, https://github.com/marpiech

ENV package_name harbour-0.1

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-pip python-dev build-essential && \
    pip install --upgrade --force-reinstall pip==9.0.3 && \
    pip install awscli --upgrade && \
    pip install dxpy --upgrade && \
    echo "Finish"

ENTRYPOINT ["aws"]
