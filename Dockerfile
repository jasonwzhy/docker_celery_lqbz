FROM python:3.6.4-slim
MAINTAINER kunlun

RUN apt-get update && apt-get install -y mysql-client sshpass gcc libmysqlclient-dev && rm -rf /var/lib/apt


# RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" >> \
#   /etc/apt/sources.list.d/webupd8team-java.list \
#   && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" >> \
#   /etc/apt/sources.list.d/webupd8team-java.list \
#   && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
#   && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
#   && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
#   && apt-get update && apt-get install -y oracle-java8-installer \
#   && rm -rf /var/lib/apt
# COPY tools/neo4j-community-3.2.6 /opt/neo4j-community-3.2.6

COPY requirements.txt /
RUN pip install -r requirements.txt && rm requirements.txt

RUN pip install mysqlclient

# ENV PATH="/opt/neo4j-community-3.2.6/bin:${PATH}"

RUN useradd -ms /bin/bash celery

USER celery

WORKDIR /proj