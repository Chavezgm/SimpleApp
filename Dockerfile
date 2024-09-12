# Use the official Ruby image as a base
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install the gems
RUN bundle install

# Copy the entire app into the container
COPY . .

# Precompile Rails assets (optional if your app has assets like JavaScript/CSS)
RUN bundle exec rake assets:precompile

# Expose the port that the app runs on
EXPOSE 3000

# Define the environment variable for RAILS_ENV
ENV RAILS_ENV=development

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
