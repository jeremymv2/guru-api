# guru-api
Ruby client to consume [GetGuru API](https://help.getguru.com/categories/api-documentation)

## Usage
```ruby
require 'guru-api'
include GuruAPI::Resource

GuruAPI.configure do |config|
  config.endpoint     = 'https://api.getguru.com/api'
  config.api_version  = 'v1'
  config.user         = ENV['guru-user']
  config.pass         = ENV['guru-pass']
  config.ssl_verify   = false
end

# Fetch by id
Cards.fetch('60921ce6-0c7f-4ff2-83b6-18192284d529')
# List all
Cards.list
# Filter by search
Cards.list('lastModified < 1_days_ago')
```
