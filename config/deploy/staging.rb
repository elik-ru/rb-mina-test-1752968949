set :nginx_server_name, "mina-test.staging.railsblueprint.com"
set :rails_env, "staging"
set :deploy_to, -> { "/home/#{fetch(:user)}/rb_test_fork/staging" }
set :hostname, "chill"
