Rails.application.configure do
  # Configure options individually...
  config.good_job.preserve_job_records = true
  config.good_job.retry_on_unhandled_error = false
  config.good_job.on_thread_error = -> (exception) { Rollbar.error(exception) }
  config.good_job.execution_mode = :async
  config.good_job.queues = '*'
  config.good_job.max_threads = 5
  config.good_job.poll_interval = 30 # seconds
  config.good_job.shutdown_timeout = 25 # seconds

  config.good_job.enable_cron = true
  config.good_job.cron = { 
    sitemap_generator: { 
      cron: '0 2 * * *', # Daily at 2 AM
      class: 'DelayedCommandJob',
      args: -> { [SitemapGeneratorCommand, {}] },
      description: 'Generate XML sitemap for SEO'
    } 
  }
end
