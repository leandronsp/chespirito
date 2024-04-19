FROM ruby:3.1.2
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . .
EXPOSE 3000
CMD ["ruby", "sample/hello_app/run"]
