set :nginx_server_name, "rb-test-fork.example.com"
set :rails_env, "production"
set :deploy_to, -> { "/home/#{fetch(:user)}/rb_test_fork/production" }
set :hostname, "example.com"
