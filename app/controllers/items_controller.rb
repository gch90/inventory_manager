class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.all
  end

  def edit; end

  def show; end

  def destroy
    if @item.shipped_items.empty? && @item.destroy
      redirect_to root_path, status: :see_other
    else
      @item.errors.add :name, 'Item in a shipment'
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:quantity, :name)
  end
end
