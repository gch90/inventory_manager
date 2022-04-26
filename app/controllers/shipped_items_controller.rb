class ShippedItemsController < ApplicationController
  # Instances created if destroy fails and renders
  before_action :set_shipped_item, only: [:destroy]

  def new
    @shipped_item = ShippedItem.new
    @item = Item.find(params[:item_id])
    @shipments = Shipment.where(status: 0)
  end

  def create
    @shipped_item = ShippedItem.new

    # creating the following instances for rendering
    @item = Item.find(shipped_items_params[:item])
    @shipments = Shipment.where(status: 0)

    set_shipped_item_params

    if @shipped_item.shipment.pending? && @shipped_item.save
      @item.quantity -= @shipped_item.quantity
      @item.save
      redirect_to shipment_path(@shipment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @shipment = @shipped_item.shipment
    @item = @shipped_item.item

    if @shipped_item.shipment.pending?
      @item.quantity += @shipped_item.quantity
      @item.save
      @shipped_item.destroy
      redirect_to shipment_path(@shipment)
    else
      @shipped_item.errors.add :shipment, 'Already shipped'
      render 'shipments/edit', status: :unprocessable_entity
    end
  end

  private

  def shipped_items_params
    params.require(:shipped_item).permit(:shipment, :quantity, :item)
  end

  def set_shipped_item
    @shipped_item = ShippedItem.find(params[:id])
  end

  def set_shipped_item_params
    # setting quantity
    @quantity = shipped_items_params[:quantity]
    @shipped_item.quantity = @quantity

    # setting item
    @item = Item.find(shipped_items_params[:item])
    @shipped_item.item = @item

    # setting shipment
    @shipment = Shipment.find(shipped_items_params[:shipment])
    @shipped_item.shipment = @shipment

    # setting shipped_item_item
    @item = Item.find(shipped_items_params[:item])
    @shipped_item.item = @item
  end
end
