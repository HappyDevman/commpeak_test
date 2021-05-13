class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :ticket, except: :new
  before_action :authorize_action

  # GET /comments/new
  def new
    @comment = comments_scope.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  def create
    @comment = comments_scope.new(comment_params)

    if @comment.save
      redirect_to ticket_path(@ticket), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to ticket_path(@ticket), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to ticket_path(@ticket), notice: 'Comment was successfully destroyed.'
  end

  private

  def ticket
    @ticket ||= Ticket.find(params[:ticket_id])
  end

  def comments_scope
    @comments_scope ||= ticket.comments
  end

  def authorize_action(record = Ticket)
    authorize(record, "#{action_name}?", policy_class: policy_class)
  end

  def policy_class
    CommentsPolicy
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
