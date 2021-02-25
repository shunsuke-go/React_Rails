FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /React_Rails
WORKDIR /React_Rails
COPY Gemfile /React_Rails/Gemfile
COPY Gemfile.lock /React_Rails/Gemfile.lock
RUN bundle install && bundle update
COPY . /React_Rails

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

#CMD ["rails", "server", "-b", "0.0.0.0"]