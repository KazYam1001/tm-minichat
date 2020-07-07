class Api::MessagesController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    render json: group.messages
  end

  def create
    group = Group.find(params[:group_id])
    message = group.messages.create(message_params)
    render json: message
  end

  private

  def message_params
    params.permit(:content)
  end
end
