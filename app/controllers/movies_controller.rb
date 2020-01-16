class MoviesController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.theater_owner 
            @movies = Movie.all.order(:title)
        else
            #  age may not be populated (esp if they use omniauth, so set age to 18, if blank)
            current_user.age ? user_age = current_user.age : user_age = 18
            @movies = Movie.age_appropriate_for_me(user_age).order(:title)
        end
    end

    def new
        @movie = Movie.new
        5.times { @movie.showings.build }
    end

    def create 
        @movie = Movie.create(movie_params)
        redirect_to movie_path(@movie)
    end

    def show
        @movie = Movie.find_by_id(params[:id])
    end

    def edit
        @movie = Movie.find_by_id(params[:id])
        @movie.showings.build 
    end

    def update
        @movie = Movie.find_by_id(params[:id])

        @movie.update(movie_params)

        if @movie.save
            redirect_to @movie
        else
            render :edit
        end
    end

    def destroy
        @movie = Movie.find_by_id(params[:id])
        binding.pry
        # We need to destroy all tickets, all showings and the movie
        if @movie.destroy
            redirect_to movies_path
        else
            flash[]
            render :edit
        end
    end
  
    private
  
    def movie_params
      params.require(:movie).permit(:title, 
                                  :description, 
                                  :genre,
                                  :release_date,
                                  :rating,
                                  showings_attributes:[:id, 
                                                        :show_date, 
                                                        :show_time] )
    end
end
