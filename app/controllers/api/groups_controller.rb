class Api::GroupsController < ApplicationController
  def index
    @groups = Group.all
    render json: @groups
  end

  def create
    group = Group.create!(group_params)
    render json: group
  end

  private

  def group_params
    params.permit(:name)
  end
end
