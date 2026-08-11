class MyFirstJob
  include Sidekiq::Job

  def perform(val, *args)
    puts "My first Sidekiq job is running!"
    performs(val)
  end

  def performs(val)
    puts "#{val}(method) Sidekiq job is running!"
  end
end
