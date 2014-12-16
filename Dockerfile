FROM ubuntu:14.04

# Set ruby version.
ENV RUBY_VERSION 2.1.5

# Set app's location.
ENV APP /grounds

# Add user dev.
RUN useradd dev

# Install dependencies.
RUN apt-get update -q && \
    apt-get -qy install \
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
    tar xzf - -C /usr/local && \
    echo "gem: --no-document" > /usr/local/etc/gemrc

# Install bundler.
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the image.
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock

# Install ruby gems.
RUN cd $APP && bundle install

# Configure pry
COPY pry/.pryrc /home/dev/.pryrc

# Everything up to here was cached. This includes
# the bundle install, unless the Gemfiles changed.

# Now copy the app into the image.
COPY . $APP

# Changes app's files owner.
RUN chown -R dev:dev $APP

# Set user as dev.
USER dev

# Set the final working dir to the Rails app's location.
WORKDIR $APP
