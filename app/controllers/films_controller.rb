class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]

  # GET /films
  # GET /films.json
  def index
    
    # Attempt to fetch films from cache before fetching from server
    @films = Rails.cache.read('films')
    if @films.nil?
      @films = Film.all
      Rails.cache.write('films', @films)
      Rails.logger.info "Writing 'films' to rails cache"
    end
    
    # Attempt to fetch films as json from cache before fetching from server
    @films_as_json = Rails.cache.read('films_as_json')
    if @films_as_json.nil?
      @films_as_json = @films.as_json(:include => :locations)
      Rails.cache.write('films_as_json', @films_as_json)
      Rails.logger.info "Writing 'films_as_json' to rails cache"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @films_as_json }
    end
  end

  # GET /films/1
  # GET /films/1.json
  def show
    @film = Film.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @film, :include => :locations }
    end
  end

  # GET /films/new
  def new
    @film = Film.new
  end

  # GET /films/1/edit
  def edit
  end

  # POST /films
  # POST /films.json
  def create
    @film = Film.new(film_params)

    respond_to do |format|
      if @film.save
        format.html { redirect_to @film, notice: 'Film was successfully created.' }
        format.json { render action: 'show', status: :created, location: @film }
      else
        format.html { render action: 'new' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def film_params
      params.require(:film).permit(:title, :release_year, :production_company, :distributor, :director, :writers, :actors)
    end
end
