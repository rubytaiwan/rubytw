# frozen_string_literal: true

set :deploy_to, '/home/deploy/ruby.tw'
role :app, %w(deploy@ruby.tw)
role :web, %w(deploy@ruby.tw)
role :db, %w(deploy@ruby.tw)
