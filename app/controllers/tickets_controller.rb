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

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save && create_charge
        format.html { redirect_to event_ticket_path(@event, @ticket), notice: 'ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_charge
    # Token is created using Stripe.js or Checkout!
    # Get the payment token submitted by the form:
    token = params[:stripeToken]

    # Charge the user's card:
    charge = Stripe::Charge.create(
      amount: (@event.price * 100).to_i,
      currency: 'usd',
      description: @event.title,
      metadata: { 'ticket_id' => @ticket.id },
      source: token
    )
  end

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
