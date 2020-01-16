class ShowingsController < ApplicationController
    
    def index
        @showings = Showing.all
      end
    
      def show
        @showing = Showing.find(params[:id])
      end
    
      def new
        # THIS NEEDS TO CHANGE TO BUILD
        @showing = Showing.new

      end
    
      def create
        @showing = Showing.new(showing_params)
    
        if @showing.save
          redirect_to @showing
        else
          render :new
        end
      end
    
      def edit
        @showing = Showing.find(params[:id])
      end
    
      def update
        @showing = Showing.find(params[:id])
    
        @showing.update(showing_params)
    
        if @showing.save
          redirect_to @showing
        else
          render :edit
        end
      end
    
      def destroy
        @showing = Showing.find(params[:id])
        @showing.destroy
        flash[:notice] = "Showing deleted."
        redirect_to showings_path
      end

      
      private
    
      def showing_params
        params.require(:showing).permit(:show_date, :show_time)
      end
    
end
