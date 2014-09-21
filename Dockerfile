FROM ubuntu:14.04

# Set ruby version.
ENV RUBY_MAJOR 2.1
ENV RUBY_MINOR 2.1.2

# Set app's location
ENV APP /grounds

# Add user grounds.
RUN useradd grounds

# Install dependencies.
RUN apt-get update -q && \
    apt-get -qy install \
    git-core \
    curl \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    python-software-properties \
    nodejs \
    phantomjs

# Install ruby.
RUN curl -O http://ftp.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_MINOR.tar.gz && \
    tar -xzvf ruby-$RUBY_MINOR.tar.gz && \
    cd ruby-$RUBY_MINOR && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-$RUBY_MINOR ruby-$RUBY_MINOR.tar.gz && \
    echo "gem: --no-document" > /usr/local/etc/gemrc

# Install bundler.
RUN gem install bundler

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

# Set user as grounds-io.
USER grounds

# Set the final working dir to the Rails app's location.
WORKDIR /grounds
