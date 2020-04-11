# frozen_string_literal: true
Doorkeeper::Application.create(name: 'ecomm', redirect_uri: 'urn:ietf:wg:oauth:2.0:oob', confidential: false, scopes: %w(read write))

User.create(name: 'murat', surname: 'bastas', phone: '05555555555', email: 'muratbsts@gmail.com', password: 'password', password_confirmation: 'password')

User.first.confirm
