#
# Dockerfile
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

FROM centos:7
MAINTAINER Matteo Cerutti <matteo.cerutti@hotmail.co.uk>

ENV PUPPET_FORGE_SERVER_USER forge
ENV PUPPET_FORGE_SERVER_USER_ID 576
ENV PUPPET_FORGE_SERVER_BASEDIR /srv/puppet-forge-server

RUN yum install gcc make ruby-devel rubygems git -y

# Needed to fetch dependencies
RUN echo ':ssl_verify_mode: 0' > ~/.gemrc
RUN gem install bundler
RUN useradd --system --create-home --uid $PUPPET_FORGE_SERVER_USER_ID --home-dir $PUPPET_FORGE_SERVER_BASEDIR $PUPPET_FORGE_SERVER_USER

WORKDIR $PUPPET_FORGE_SERVER_BASEDIR
USER $PUPPET_FORGE_SERVER_USER

RUN echo "source 'https://rubygems.org'" >> Gemfile
RUN echo "gem 'puppet-forge-server', :git => 'https://github.com/coi-gov-pl/puppet-forge-server.git', :branch => 'feature/add-cache-for-remote'" >> Gemfile
RUN echo "gem 'puma'" >> Gemfile
RUN cat Gemfile
RUN bundle --retry=3

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
