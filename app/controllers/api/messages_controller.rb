class Api::MessagesController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    render json: group.messages
  end
end
