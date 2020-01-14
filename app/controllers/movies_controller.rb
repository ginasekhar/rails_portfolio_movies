class MoviesController < ApplicationController
    before_action :authenticate_user!

    def home

    end
    
    def index
        if current_user.theater_owner 
            @movies = Movie.all
        else
            # Since age may not be populated (esp if they use omniauth, set age to 18)
            current_user.age ? user_age = current_user.age : user_age = 18
            @movies = Movie.age_appropriate_for_me(user_age)
        end
    end

    def new
        @movie = Movie.new
        5.times { @movie.showings.build }
    end

    def create 
        binding.pry
        @movie = Movie.create(movie_params)
        redirect_to movie_path(@movie)
    end

    def show
        #binding.pry
        @movie = Movie.find_by_id(params[:id])
        #@showing = @movie.showings.build(movie_id: @movie.id)
        #@ticket = @movie.tickets.build(user_id: current_user.id)
    end

    def edit
        @movie = Movie.find_by_id(params[:id])
        5.times { @movie.showings.build }
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
