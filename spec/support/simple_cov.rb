# frozen_string_literal: true
# SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter 'spec'
  add_filter 'app/jobs'
  add_filter 'app/controllers/auth' # they're devise controllers
  add_filter 'app/mailers'
  add_filter 'app/controllers/concerns'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Services', 'app/services'
end
