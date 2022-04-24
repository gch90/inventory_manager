class ShippedItemsController < ApplicationController
  # Instances created if destroy fails and renders
  before_action :set_shipped_item, only: [:destroy]

  def create
    # instances created if create fails and renders
    @shipments = Shipment.all.pending
    @shipped_item = ShippedItem.new
    set_item
    ###########

    # Verifying that a shipment is sent from simple_form
    if shipped_items_params[:shipment].empty?
      @shipped_item.errors.add :shipment, 'Can\'t be blank'
      render 'items/show', status: :unprocessable_entity and return
    end

    set_shipped_item_params

    if @shipped_item.save
      @item.quantity -= @shipped_item.quantity
      @item.save
      redirect_to shipment_path(@shipment)
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  def destroy
    # Intances created if create fails and renders
    @item = Item.find(shipped_items_params[:item])

    if @shipped_item.shipment.pending?
      @shipped_item.destroy
    else
      render 'items/show', status: :unprocessable_entity
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

  def set_shipped_item
    @shipped_item = ShippedItem.find(params[:id])
  end

  def set_shipped_item_params
    @quantity = shipped_items_params[:quantity]
    @shipped_item.quantity = @quantity

    @shipment = Shipment.find(shipped_items_params[:shipment])
    @shipped_item.shipment = @shipment
  end
end
