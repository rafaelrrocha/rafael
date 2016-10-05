class AddFotoToFilmes < ActiveRecord::Migration
  def change
    add_column :filmes, :foto, :string
  end
end
