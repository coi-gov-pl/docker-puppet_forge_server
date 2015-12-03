#
# Dockerfile
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

FROM centos:7
MAINTAINER Matteo Cerutti <matteo.cerutti@hotmail.co.uk>

ENV PUPPET_FORGE_SERVER_USER forge
ENV PUPPET_FORGE_SERVER_USER_ID 576
ENV PUPPET_FORGE_SERVER_RACK puma
ENV PUPPET_FORGE_SERVER_BASEDIR /srv/puppet-forge-server

RUN yum install gcc make ruby-devel rubygems -y

# Needed to fetch dependencies
RUN echo ':ssl_verify_mode: 0' > ~/.gemrc
RUN gem install puppet-forge-server -v 1.8.0
RUN gem install $PUPPET_FORGE_SERVER_RACK
RUN useradd --system --create-home --uid $PUPPET_FORGE_SERVER_USER_ID --home-dir $PUPPET_FORGE_SERVER_BASEDIR $PUPPET_FORGE_SERVER_USER

ADD run.sh /run.sh

WORKDIR $PUPPET_FORGE_SERVER_BASEDIR
USER $PUPPET_FORGE_SERVER_USER
ENTRYPOINT ["/run.sh"]
