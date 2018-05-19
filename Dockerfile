FROM ubuntu:18.04
MAINTAINER Marcin Piechota, https://github.com/marpiech

ENV package_name harbour-0.1

ADD https://raw.githubusercontent.com/BioHack2018/Z-3/master/flatten-nested-json.py /usr/local/bin/
ADD https://raw.githubusercontent.com/BioHack2018/Z-3/master/upload-file-and-json.bash /usr/local/bin/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-pip python-dev build-essential && \
    pip install --upgrade --force-reinstall pip==9.0.3 && \
    pip install awscli --upgrade && \
    pip install dxpy --upgrade && \
    chmod 750 /usr/local/bin/upload-file-and-json.bash && \
    echo "Finish"


ENTRYPOINT ["aws"]
