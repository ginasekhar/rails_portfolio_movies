class MoviesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_theater_owner!, except: [:show, :index]


    def index
        # Theater owner sees all movies
        if current_user.theater_owner
            @movies = Movie.order(:title)
        else
            #  age may not be populated (esp if they use omniauth, so pretend age is 18, if blank
            # I considered making the default the most restrictive age, but decided to make it
            # least restrictive since I'm using github for Oauth and github probably has mostly adults
            current_user.age ? user_age = current_user.age : user_age = 18

            # retrieve movies by scope age_appropriate
            @movies = Movie.age_appropriate_for_me(user_age).order(:title)
        end
    end

    def new
        # allow entry of 5 showing when creating movie
        @movie = Movie.new
        5.times { @movie.showings.build }
    end

    def create 
        @movie = Movie.create(movie_params)
    
        if @movie.errors.any?
            flash[:error] =  @movie.errors.full_messages.to_sentence
            5.times { @movie.showings.build } #so we have it when we render the form again
            render :new 
        else
            flash[:notice] =  "Movie #{@movie.title} created"
            redirect_to movie_path(@movie)    
        end
    end

    def show
        if current_user.theater_owner
            @movie = Movie.find_by(id: params[:id])
        else
            current_user.age ? user_age = current_user.age : user_age = 18
            @movie = Movie.age_appropriate_for_me(user_age).find_by(id: params[:id])
        end
        if !@movie
            flash[:error] =  @movie.errors.full_messages.to_sentence
            redirect_to movies_path
        end
        
    end

    def edit
        @movie = Movie.find_by(id: params[:id])
        # build one instance in case user wants to add a showing
        @movie.showings.build 
    end

    def update
        @movie = Movie.find_by(id: params[:id])
        if @movie && @movie.update(movie_params) && @movie.save
            flash[:notice] =  "Movie #{@movie.title} updated"
            redirect_to movie_path(@movie)
        else
            flash[:error] =  @movie.errors.full_messages.to_sentence
            render :edit
        end
    end

    def destroy
        
        @movie = Movie.find_by(id: params[:id])
        @movie.destroy
        #binding.pry
        if @movie.errors.any?
            flash[:error] =  @movie.errors.full_messages.to_sentence
            redirect_to movie_path(@movie) 
        else
            flash[:notice] =  "Movie #{@movie.title} deleted"
            redirect_to movies_path
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
