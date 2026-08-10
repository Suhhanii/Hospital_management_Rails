class MyFirstJob
  include Sidekiq::Job

  def perform(val)
    puts "My first Sidekiq job is running!"
  end
end
