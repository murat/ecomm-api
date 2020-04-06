# SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start "rails" do
  add_filter "spec"
  add_filter "test"
  add_filter "app/helpers"
  add_filter "app/uploaders"
  add_filter "app/mailers"
  add_filter "app/serializers"

  add_group "Models", "app/models"
  add_group "Services", "app/services"
end
