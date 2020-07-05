class Api::GroupsController < ApplicationController
  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    @group = (params[:id] == 'undefined') ? Group.first : Group.find(params[:id])
    render json: @group
  end

  def create
    group = Group.create(group_params)
    render json: group
  end

  def update
    group = Group.find(params[:id])
    group.update(group_params)
    render json: group
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    render json: {id: params[:id]}
  end

  private

  def group_params
    params.permit(:name)
  end
end
