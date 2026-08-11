class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "test job runnig"
  end
end
