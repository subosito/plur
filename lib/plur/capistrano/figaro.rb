Capistrano::Configuration.instance(:must_exist).load do
  namespace :figaro do
    _cset :figaro_yaml,    true
    _cset :figaro_symlink, true
    _cset(:figaro_output)  { "#{shared_path}/application.yml" }
    _cset(:figaro_config)  { "#{latest_release}/config/application.yml" }

    task :config, roles: :app do
      figaro_tmpfile = "figaro-#{rails_env}"

      if figaro_yaml
        figaro_cmd = %Q(Figaro.env("#{rails_env}").to_yaml)
      else
        figaro_cmd = %Q(Figaro.vars("#{rails_env}").split)
      end

      run_locally "bundle exec rails runner 'puts #{figaro_cmd}' > #{figaro_tmpfile}"
      transfer :up, figaro_tmpfile, figaro_output, via: :scp
      run_locally "rm #{figaro_tmpfile}"
    end
  end

  after 'deploy:setup', 'figaro:config'

  after 'deploy:finalize_update' do
    run "ln -sf #{figaro_output} #{figaro_config}" if figaro_symlink
  end
end
