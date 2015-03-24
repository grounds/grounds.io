FROM ubuntu:14.04

# Set ruby version.
ENV RUBY_VERSION 2.1.5

# Set app's location.
ENV APP /grounds

# Add user dev.
RUN useradd dev

# Install dependencies.
RUN apt-get update -qq && \
    apt-get install -qy \
    git \
    curl \
    build-essential \
    libxslt1-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libsqlite3-dev \
    nodejs \
    phantomjs

# Install ruby.
RUN curl -sL http://s3.amazonaws.com/pkgr-buildpack-ruby/current/ubuntu-14.04/ruby-$RUBY_VERSION.tgz -o - | \
    tar xzf - -C /usr/local

# Configure home and gem path for user dev.
ENV HOME /home/dev
ENV GEM_HOME $HOME/.gem/ruby
ENV GEM_PATH $GEM_HOME
ENV PATH $PATH:$GEM_PATH/bin

# Create home and gem path.
RUN mkdir -p $GEM_PATH/cache

# Default configuration for gem installation.
RUN echo "gem: --no-document" > $HOME/.gemrc

# Configure pry.
COPY pry/.pryrc $HOME/.pryrc

# Change home and dev path owner.
RUN chown -R dev:dev $HOME

# Set user as dev.
USER dev

# Install bundler.
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the image.
COPY Gemfile $APP/
COPY Gemfile.lock $APP/

# Install ruby gems.
RUN cd $APP && bundle install

# Everything up to here was cached. This includes
# the bundle install, unless the Gemfiles changed.

# Now copy the app into the image.
COPY . $APP

# Set user as root.
USER root

# Changes app's files owner.
RUN chown -R dev:dev $APP

# Set user as dev.
USER dev

# Set the final working dir to the Rails app's location.
WORKDIR $APP
