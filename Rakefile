# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# Warning: this is meant to work inside a docker container.
# Outside a docker container, only the master task is avalaible.

if ENV['CONTAINER'] 

  require File.expand_path('../config/application', __FILE__)

  Rails.application.load_tasks

else

  load './hack/docker.rake'

end
