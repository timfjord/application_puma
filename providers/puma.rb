include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do
end

action :before_deploy do
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
  include_recipe 'puma'
  
  new_resource = @new_resource
  
  current_path = ::File.join(new_resource.path, 'current')
  config_path = ::File.join(new_resource.path, 'shared', 'config', 'puma.rb')
  pidfile_path = ::File.join(new_resource.path, 'shared', 'tmp', 'pids', 'puma.pid')
  puma_config config_path do
    pidfile pidfile_path
    state_path state_param_path
    bind new_resource.bind
    owner new_resource.user
  end
  
  with_context new_resource.application_provider.run_context do
    puma_monit new_resource.name do
      path current_path
      pidfile pidfile_path
      config config_path
      user new_resource.user
    end
  end
end

action :after_restart do
end

def with_context(context)
  saved_run_context = @run_context
  @run_context = context
  yield
  @run_context = saved_run_context
end