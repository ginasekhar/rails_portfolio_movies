class TicketsController < ApplicationController
    before_action :authenticate_user!
    
    @@ticket_price_hash = {"Adult" => 20.00, "Child" => 8.00, "Senior" => 12.00, "Student" => 10.00}
    def index
        #theater owner get routed here 
        
        if params[:showing_id]
            @showing = Showing.find_by_id(params[:showing_id])
            if current_user.theater_owner
                @tickets = @showing.tickets
                @tickets_count = @tickets.count
                @showing_revenue = @showing.tickets.sum(:price)
                
            end
        else
            @tickets = Ticket.my_tickets(current_user)
            @tickets_count = @tickets.count
        end
    end

    def new
        if params[:showing_id]
            @showing = Showing.find_by_id(params[:showing_id])
            @ticket = @showing.tickets.build
        end
    end

    def create 
        @ticket = Ticket.new(ticket_params)
        @ticket.user = current_user
        @ticket.price = @@ticket_price_hash[@ticket.ticket_type]
        @ticket.save
        #binding.pry
        redirect_to tickets_path

    end

    def show
        @ticket = Ticket.find_by_id(params[:id])
    end

    def destroy
        @ticket = Ticket.find_by_id(params[:id])
        @ticket.destroy
        #flash[:notice] = "Ticket cancelled"
        redirect_to tickets_path
    end

    private
  
    def ticket_params
      params.require(:ticket).permit(:user_id, 
                                  :showing_id, 
                                  :ticket_type,
                                  :price)
    end
end
