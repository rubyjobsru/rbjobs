bind 'unix:///tmp/puma.rubyjobs.sock'
environment (ENV['RACK_ENV'] || 'production' )
threads (ENV['PUMA_MIN_THREADS'] || 4 ), (ENV['PUMA_MAX_THREADS'] || 4 )
workers (ENV['PUMA_WORKERS'] || 2 )
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
