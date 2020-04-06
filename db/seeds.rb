Doorkeeper::Application.create(name: "ecomm", redirect_uri: "urn:ietf:wg:oauth:2.0:oob", confidential: false, scopes: ["read", "write"])
User.create(name: "murat", surname: "bastas", email: "muratbsts@gmail.com", password: "password", password_confirmation: "password")
User.find_each(&:confirm)
