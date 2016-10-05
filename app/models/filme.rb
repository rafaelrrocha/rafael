class Filme < ActiveRecord::Base
	validates_presence_of :titulo, message: "O título deve ser preenchido!"
	validates_presence_of :genero, message: "O gênero deve ser preenchido!"
	validates_presence_of :ator, message: "O ator deve ser preenchido!"
	validates_presence_of :preco, message: "O preço deve ser preenchido!"


	validates_numericality_of :preco, message: "O preço deve ser numérico!"

	mount_uploader :foto, FotoFilmeUploader
end
