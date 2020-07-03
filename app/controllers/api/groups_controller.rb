class Api::GroupsController < ApplicationController
  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    @group = (params[:id] == 'undefined') ? Group.first : Group.find(params[:id])
    render json: @group
  end
end
