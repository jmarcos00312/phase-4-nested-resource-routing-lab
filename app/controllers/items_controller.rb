class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: find_item
  end

  def create
    user = find_user
    items = user.items.create(items_params)
    render json: items, status: :created
  end


  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def items_params
    params.permit(:name, :description, :price)
  end

def render_not_found_response(exception)
    render json: { errors: "404 user not found" }, status: :not_found
end
end
