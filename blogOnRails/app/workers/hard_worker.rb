class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    Post.find(args[0]).destroy!
  end
end
