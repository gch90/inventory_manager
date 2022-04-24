class ShippedItemsController < ApplicationController
  before_action :set_shipped_item, :set_item, only: [:destroy]
  before_action :set_pending_shipments, only: [:create]

  def create
    @shipped_item = ShippedItem.new
    set_item
    set_shipment
    set_shipped_quantity

    if @shipped_item.save
      @item.quantity -= @shipped_item.quantity
      @item.save
      redirect_to shipment_path(@shipment)
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  def destroy
    if @shipped_item.shipment.pending?
      @shipped_item.destroy
    else
      render item_path(@item), status: :unprocessable_entity
    end
  end

  private

  def shipped_items_params
    params.require(:shipped_item).permit(:shipment, :quantity, :item)
  end

  def set_item
    @item = Item.find(shipped_items_params[:item])
    @shipped_item.item = @item
  end

  def set_shipment
    @shipment = Shipment.find(shipped_items_params[:shipment])
    @shipped_item.shipment = @shipment
  end

  def set_shipped_quantity
    @quantity = shipped_items_params[:quantity]
    @shipped_item.quantity = @quantity
  end

  def set_shipped_item
    @shipped_item = ShippedItem.find(params[:id])
  end

  def set_pending_shipments
    @shipments = Shipment.all.pending
  end
end
