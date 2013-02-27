Capistrano::Configuration.instance(:must_exist).load do
  namespace :local do
    desc 'Run the precompile task locally and rsync with shared'
    task :assets, roles: :web, except: { no_release: true } do
      remote_path = "#{user}@#{domain}:#{shared_path}"

      run_locally "bundle exec rake assets:precompile"
      run_locally "rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{remote_path}"
      run_locally "bundle exec rake assets:clean"
    end
  end

  namespace :deploy do
    namespace :assets do
      task :precompile, roles: :web, except: { no_release: true } do
        local.assets
      end
    end
  end
end
