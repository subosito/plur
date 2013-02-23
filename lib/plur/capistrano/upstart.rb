Capistrano::Configuration.instance(:must_exist).load do
  namespace :upstart do
    _cset(:service_name) { "app/#{application}" }

    desc "Start the application services"
    task :start, roles: :app do
      run "#{sudo} service #{service_name} start"
    end

    desc "Stop the application services"
    task :stop, roles: :app do
      run "#{sudo} service #{service_name} stop"
    end

    desc "Restart the application services"
    task :restart, roles: :app do
      run "#{sudo} service #{service_name} start || #{sudo} service #{service_name} restart"
    end
  end

  after 'deploy:restart', 'upstart:restart'
end
