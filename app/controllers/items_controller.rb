class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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

  def show
    @shipments = Shipment.where(status: 0)
    @shipped_item = ShippedItem.new
  end

  def destroy
    if @item.shipped_items
      render :edit, status: :unprocessable_entity
    else
      @item.destroy
      redirect_to root_path, status: :see_other
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
