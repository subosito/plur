Capistrano::Configuration.instance(:must_exist).load do
  namespace :upstart do
    desc "Start the application services"
    task :start, :roles => :app do
      run "#{sudo} service #{application} start"
    end

    desc "Stop the application services"
    task :stop, :roles => :app do
      run "#{sudo} service #{application} stop"
    end

    desc "Restart the application services"
    task :restart, :roles => :app do
      run "#{sudo} service #{application} start || #{sudo} service #{application} restart"
    end
  end

  after 'deploy:restart', 'upstart:restart'
end
