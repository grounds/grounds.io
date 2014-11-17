FROM ubuntu:14.04

# Set ruby version.
ENV RUBY_VERSION 2.1.5

# Set app's location.
ENV APP /grounds

# Add user grounds.
RUN useradd grounds

# Install dependencies.
RUN apt-get update -q && \
    apt-get -qy install \
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

# Add file for pry history
RUN mkdir /home/grounds
RUN touch /home/grounds/.pry_history
RUN chown -R grounds:grounds /home/grounds

# Copy the Gemfile and Gemfile.lock into the image.
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock

# Install ruby gems.
RUN cd $APP && bundle install

# Everything up to here was cached. This includes
# the bundle install, unless the Gemfiles changed.

# Now copy the app into the image.
COPY . $APP

# Changes app's files owner.
RUN chown -R grounds:grounds $APP

# Set user as grounds.
USER grounds

# Set the final working dir to the Rails app's location.
WORKDIR /grounds
