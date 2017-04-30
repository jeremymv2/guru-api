module GuruAPI
  class Resource::Cards < Resource::Base
    resource_path '/cards/<id>/extended'
    list_path '/search/query'
  end
end
