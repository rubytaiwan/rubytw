# frozen_string_literal: true

set :deploy_to, '/home/deploy/ruby.tw'
role :app, %w(deploy@10.128.128.154)
role :web, %w(deploy@10.128.128.154)
role :db, %w(deploy@10.128.128.154)
