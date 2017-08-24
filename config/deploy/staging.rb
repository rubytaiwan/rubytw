# frozen_string_literal: true
set :rails_env, 'production'

set :deploy_to, '/home/deploy/staging-www.ruby.tw'
role :app, %w(deploy@10.128.128.153)
role :web, %w(deploy@10.128.128.153)
role :db, %w(deploy@10.128.128.153)
