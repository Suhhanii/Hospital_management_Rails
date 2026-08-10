# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

REDIS_URL="redis://localhost:6379/1"
