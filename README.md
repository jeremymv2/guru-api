# guru-api
Ruby client to consume Guru API

## Usage
```ruby
require 'guru-api'

include GuruAPI::Resource

# Fetch by id
Cards.fetch('60921ce6-0c7f-4ff2-83b6-18192284d529')
# List all
Cards.list
# Filter by search
Cards.list('lastModified < 1_days_ago')
```
