class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end


  def index
    
    redirect = false
    @movies = Movie.all
    
    @all_ratings = []
    @movies.each { |m|
      @all_ratings.push(m.get_rating)
    }
    @all_ratings  = @all_ratings.uniq!
    
    @sort = params[:sort_by]
    if @sort == "title"
      @movies = Movie.order(:title)
      @title = "hilite"
    elsif @sort == "release_date"
      @movies = Movie.order(:release_date)
      @date = "hilite"
    end
    
    # if !params[:sort_by] && session[:sort_by]
    #   @sort = session[:sort_by]
    #   redirect = true
    # end
    
    # if !params[:ratings] && session[:ratings]
    #   @ratings = session[:ratings]
    #   redirect = true
    # end
    
    @ratings = params[:ratings] 
    @movies = Movie.where(rating: @ratings.keys) if !@ratings.nil?
    
    # if redirect
      
    #   redirect_to movies_path(:sort_by => @sort, :ratings => @ratings)
      
    # end
    
    # session[:sort_by] = @sort
    # session[:ratings] = @ratings
  
  end
    
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
end
