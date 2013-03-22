include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do
  include_recipe 'puma'
  
  new_resource = @new_resource
  
  current_path = ::File.join(new_resource.path, 'current')
  config_path = ::File.join(new_resource.path, 'shared', 'config', 'puma.rb')
  pidfile_path = ::File.join(new_resource.path, 'shared', 'tmp', 'pids', 'puma.pid')
  state_param_path = ::File.join(new_resource.path, 'shared', 'tmp', 'pids', 'puma.state')
  puma_config config_path do
    pidfile pidfile_path
    state_path state_param_path
    bind new_resource.bind
    owner new_resource.user
  end
  
  puma_app "#{current_path}" do
    action :remove
  end
  
  puma_app "#{current_path}" do
    user new_resource.user
    config config_path
    log ::File.join(new_resource.path, 'shared', 'log', 'puma.log')
  end
end

action :before_deploy do
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end
