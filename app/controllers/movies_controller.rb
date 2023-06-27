class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :set_clients, only: %i[ new edit create destroy update]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
    #@clients = Client.where.not(id: Movie.where.not(client_id: nil).pluck(:client_id)).pluck(:name)
    @clients = Client.all.pluck :name, :id
    @clients << ["Liberar_Pelicula", '']
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie fue creada." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|

      if params[:movie][:client_id].nil?
        @movie.assign.attributes(movie_params.merge(client_id: nill))
      end


      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie fue actualizada." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie fue eliminada." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_clients
      @clients = Client.all.pluck :name, :id
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:name, :client_id, :obs)
    end
end
