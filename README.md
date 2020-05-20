# Ecomm

Simple e-commerce backend API.

Project created by:

```shell script
rails new ecomm -B -C -J -T -S --api --database postgresql --skip-keeps --skip-action-mailbox --skip-action-text --skip-active-storage
```

## Installation

### Requirements

| |Version|
|---|---|
|Ruby|2.7.1|
|Bundler|2.1.4|

You can change versions from Gemfile and Gemfile.lock

```shell script
git clone git@github.com:murat/ecomm-api.git && cd ecomm-api
bundle install
rails db:create db:migrate db:seed
rails server -p 3000 -b 0.0.0.0
```
