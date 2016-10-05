json.extract! filme, :id, :titulo, :genero, :ator, :preco, :created_at, :updated_at
json.url filme_url(filme, format: :json)