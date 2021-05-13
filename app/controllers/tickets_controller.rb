class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]
  before_action :authorize_action

  # GET /tickets
  def index
    @search_term = params[:search].presence
    @filter_status = params[:filter_status].presence
    @tickets = @search_term.present? ? Ticket.search(@search_term).all : Ticket.all
    @tickets = @tickets.where(status: params[:filter_status]) if @filter_status
  end

  # GET /tickets/1
  def show
    @comments = @ticket.comments
  end

  # GET /tickets/new
  def new
    @ticket = tickets_scope.new
  end

  # GET /tickets/1/edit
  def edit; end

  # POST /tickets/submit
  def submit
    @ticket = tickets_scope.new(ticket_params)

    if @ticket.valid?
      CsvExporter.call(@ticket)
      redirect_to tickets_path, notice: 'Ticket was successfully submitted.'
    else
      render :new
    end
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    elsif @ticket.errors.key?(:comments)
      redirect_to ticket_path(@ticket), alert: @ticket.errors.messages[:comments].first
    else
      render :edit
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: 'Ticket was successfully destroyed.'
  end

  # GET /import_csv
  def import_csv
    result = CsvImporter.call(current_user)
    notification = result ? { notice: "#{result} tickets was successfully imported." } : { alert: "Can't find csv file" }
    redirect_to tickets_path, notification
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def tickets_scope
    @tickets_scope ||= current_user.tickets
  end

  def authorize_action(record = Ticket)
    authorize(record, "#{action_name}?", policy_class: policy_class)
  end

  def policy_class
    TicketsPolicy
  end

  def ticket_params
    params.require(:ticket).permit(:name, :email, :subject, :content, :status)
  end
end
