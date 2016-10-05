class FilmesController < ApplicationController
  before_action :set_filme, only: [:show, :edit, :update, :destroy]

  # GET /filmes
  # GET /filmes.json
  def index
    @filmes = Filme.all.paginate(page: params[:page], per_page: 3)
  end

  # GET /filmes/1
  # GET /filmes/1.json
  def show
  end

  # GET /filmes/new
  def new
    @filme = Filme.new
  end

  # GET /filmes/1/edit
  def edit
  end

  # POST /filmes
  # POST /filmes.json
  def create
    @filme = Filme.new(filme_params)

    respond_to do |format|
      if @filme.save
        format.html { redirect_to @filme, notice: 'Filme was successfully created.' }
        format.json { render :show, status: :created, location: @filme }
      else
        format.html { render :new }
        format.json { render json: @filme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filmes/1
  # PATCH/PUT /filmes/1.json
  def update
    respond_to do |format|
      if @filme.update(filme_params)
        format.html { redirect_to @filme, notice: 'Filme was successfully updated.' }
        format.json { render :show, status: :ok, location: @filme }
      else
        format.html { render :edit }
        format.json { render json: @filme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filmes/1
  # DELETE /filmes/1.json
  def destroy
    @filme.destroy
    respond_to do |format|
      format.html { redirect_to filmes_url, notice: 'Filme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filme
      @filme = Filme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filme_params
      params.require(:filme).permit(:titulo, :genero, :ator, :preco, :foto)
    end


    def listar
      @filmes = Filme.all.paginate(page: params[:page], per_page: 10)
      respond_to do |format|
      format.html
      format.pdf do
      pdf = FuncionariosReport.new(@funcionarios)
      send_data pdf.render, filename: 'FilmesListagem.pdf', :width =>
      pdf.bounds.width,
      type: 'application/pdf', disposition: :inline, :page_size => "A4",
      :page_layout => :portrait
end
end
end
end



class FilmesReport < Prawn::Document
def initialize(filmes)
super()
@totprec = 0
@filmes = filmes
header
text_content
table_content
sumary
end
def header
#This inserts an image in the pdf file and sets the size of the image
image "#{Rails.root}/app/assets/images/header.png", width: 530, height: 100
end
def text_content
y_position = cursor - 50
# The bounding_box takes the x and y coordinates for positioning its content and
some options to style it
bounding_box([0, y_position], :width => 540, :height => 50) do
text "Locadora Locatop", size: 15, style: :bold
text "Listagem de filmes", size: 12, style: :bold
end
end
def table_content
table filme_rows do
row(0).font_style = :bold
self.header = true
self.row_colors = ['DDDDDD', 'FFFFFF']
self.column_widths = [90,200, 200, 50]
end
end
def filme_rows
[['Matricula','Nome', 'Salario']] +
@filmes.map do |filme|
[filme.matricula,filme.nome,filme.preco]
end
end

def sumary
@filme.each do |filme|
@totprec += filme.preco if filme.preco
end

y_position = cursor - 50
bounding_box([0, y_position], :width => 540, :height => 50) do
text "Total Preço: #{@totprec} ", size: 15, style: :bold  
end
end
end