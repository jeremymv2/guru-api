module GuruAPI
  module Resource
    # Cards Resource
    class Cards < Resource::Base
      resource_path '/cards/<id>/extended'
      list_path '/search/query'
    end
  end
end
