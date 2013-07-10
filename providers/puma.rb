include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do
  unless new_resource.restart_command
    new_resource.restart_command do
      execute "monit restart #{new_resource.name}.puma" do
        user "root"
      end
    end
  end
end

action :before_deploy do
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
  new_resource = @new_resource
  
  with_context new_resource.application_provider.run_context do
    puma_config new_resource.name do
      directory new_resource.path
      bind new_resource.bind
      owner new_resource.user
      monit_timeout new_resource.monit_timeout
      config_source new_resource.config_source
      config_cookbook new_resource.config_cookbook
      init_file new_resource.init_file
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