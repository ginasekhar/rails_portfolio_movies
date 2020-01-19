class ShowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_theater_owner!, except: [:show, :index]

      def show
        @showing = Showing.find_by(id: params[:id])
        #flash[:error] =  @showing.errors.full_messages.to_sentence if !@showing  
      end
    
      def destroy
        if @showing = Showing.find_by(id:params[:id])
          if @showing.tickets.any?
            flash[:error] = "Cannot delete showing with tickets"
            redirect_to @showing
          elsif @showing.destroy
            flash[:notice] = "Showing deleted."
            redirect_to @showing.movie
          else 
            flash[:error] =  @showing.errors.full_messages.to_sentence
            redirect_to @showing
          end
        else
          flash[:error] = "Cannot delete showing with tickets"
        end
     
        binding.pry
      end

      
      private
    
      def showing_params
        params.require(:showing).permit(:show_date, :show_time)
      end
    
end