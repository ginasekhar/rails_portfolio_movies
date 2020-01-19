class TicketsController < ApplicationController
    before_action :authenticate_user!
    
    @@ticket_price_hash = {"Adult" => 20.00, "Child" => 8.00, "Senior" => 12.00, "Student" => 10.00}
    def index
        if params[:showing_id]
            #theater owner get routed here 
            @showing = Showing.find_by_id(params[:showing_id])
            if !@showing
                flash[:error] =  @showing.errors.full_messages.to_sentence
                #binding.pry
                redirect_to showings_path(@movie)
            end

            if current_user.theater_owner
                @tickets = @showing.tickets
                @tickets_count = @tickets.count
                @showing_revenue = @showing.tickets.sum(:price)
            end
        else
            # regular customer
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
        #binding.pry
        @ticket = current_user.tickets.build(ticket_params)
        @ticket.price = @@ticket_price_hash[@ticket.ticket_type]
        if @ticket && @ticket.valid? && @ticket.save 
            
            flash[:notice] = "Ticket purchased"
            redirect_to tickets_path
        else
            flash[:error] = @ticket.errors.full_messages.to_sentence
            render :new
        end
    end

    def show
        if current_user.theater_owner
            @ticket = Ticket.find_by_id(params[:id])
        else
            @ticket = Ticket.my_tickets(current_user).find_by_id(params[:id])
        end
        if !@ticket
            flash[:error] = "Ticket not found"
            if current_user.theater_owner
                redirect_to showing_tickets_path(@showing)
            else
                redirect_to tickets_path  
            end
        end 
    end

    def destroy
        if current_user.theater_owner
            @ticket = Ticket.find_by_id(params[:id])
        else
            @ticket = Ticket.my_tickets(current_user).find_by_id(params[:id])
        end
        if @ticket && @ticket.destroy
            flash[:notice] = "Ticket cancelled"
            
        else
            flash[:error] = "Ticket not cancelled"  
        end
        if current_user.theater_owner
            redirect_to showing_tickets_path(@showing)
        else
            redirect_to tickets_path  
        end
    end

    private
  
    def ticket_params
      params.require(:ticket).permit(:user_id, 
                                  :showing_id, 
                                  :ticket_type,
                                  :price)
    end
end
