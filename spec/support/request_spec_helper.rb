module RequestSpecHelper
  def get_token(scope, user = nil)
    user = FactoryBot.create(:user) if user.nil?
    application = FactoryBot.create(:doorkeeper_app,
                                    name: "#{scope} application",
                                    scopes: scope)
    FactoryBot.create(:doorkeeper_token, application: application, resource_owner_id: user.id, scopes: scope)
  end

  def create_project_for(user)
    project = FactoryBot.create(:project)
    role = FactoryBot.create(:role, resource_id: project.id)
    FactoryBot.create(:users_role, user_id: user.id, role_id: role.id)
    project
  end

  def create_project_list_for(user, number)
    projects = FactoryBot.create_list(:project, number)
    projects.each do |project|
      role = FactoryBot.create(:role, resource_id: project.id)
      FactoryBot.create(:users_role, user_id: user.id, role_id: role.id)
    end
    projects
  end

  def version
    "v1"
  end

  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper

  if defined? FactoryBot
    FactoryBot::SyntaxRunner.send(:include, RequestSpecHelper)
  end
end
