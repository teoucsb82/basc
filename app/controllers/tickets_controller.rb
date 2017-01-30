class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user
  before_filter :set_event, only: [:new, :create, :show]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = @user.tickets
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to event_ticket_path(@event, @ticket), notice: 'ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:event_id).merge(user_id: current_user.id)
  end
end
