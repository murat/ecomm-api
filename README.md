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

## Usage

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/00277bb28f6f3dfa8427#?env%5BEcomm%20API%20Dev%20Env%5D=W3sia2V5IjoiZW1haWwiLCJ2YWx1ZSI6Im11cmF0YnN0c0BnbWFpbC5jb20iLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6InBhc3N3b3JkIiwidmFsdWUiOiJwYXNzd29yZCIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYWNjZXNzVG9rZW4iLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoicmVmcmVzaFRva2VuIiwidmFsdWUiOiIiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6InByb3RvY29sIiwidmFsdWUiOiJodHRwIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJob3N0IiwidmFsdWUiOiJsb2NhbGhvc3QiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6InBvcnQiLCJ2YWx1ZSI6IjMwMDAiLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6Im5hbWVzcGFjZSIsInZhbHVlIjoiYXBpIiwiZW5hYmxlZCI6dHJ1ZX0seyJrZXkiOiJ2ZXJzaW9uIiwidmFsdWUiOiJ2MSIsImVuYWJsZWQiOnRydWV9LHsia2V5IjoiYmFzZVVybCIsInZhbHVlIjoie3twcm90b2NvbH19Oi8ve3tob3N0fX06e3twb3J0fX0iLCJlbmFibGVkIjp0cnVlfSx7ImtleSI6ImFwaVVybCIsInZhbHVlIjoie3tiYXNlVXJsfX0ve3tuYW1lc3BhY2V9fS97e3ZlcnNpb259fSIsImVuYWJsZWQiOnRydWV9XQ==)
