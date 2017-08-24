set :stage, :production

set :ssh_options, {
  forward_agent: true
}

role :app, %w{5xruby@srv.5xruby.tw:14159}
role :web, %w{5xruby@srv.5xruby.tw:14159}
role :db,  %w{5xruby@srv.5xruby.tw:14159}

set :deploy_to, '/home/5xruby/ruby.tw'
set :default_env, path: '/usr/local/ruby24/bin:$PATH'
