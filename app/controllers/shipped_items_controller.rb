class ShippedItemsController < ApplicationController
  # Instances created if destroy fails and renders
  before_action :set_shipped_item, only: %i[destroy]
  before_action :new_shipped_item, only: %i[new create]

  def new
    @item = Item.find(params[:item_id])
    @shipments = Shipment.where(status: 0)
  end

  def create
    # creating the following instances for rendering
    @item = Item.find(shipped_items_params[:item])
    @shipments = Shipment.where(status: 0)


    # Verifying that a shipment is sent from simple_form new_shipped_item_view
    if shipped_items_params[:shipment].empty?
      @shipped_item.errors.add :shipment, 'Can\'t be blank'
      render :new, status: :unprocessable_entity and return
      raise

    # Verifying that an item is sent from simple_form edit_shipment_view
    elsif shipped_items_params[:item].empty?
      @shipped_item.errors.add :item, 'Can\'t be blank'
      render :new, status: :unprocessable_entity and return
    end

    set_shipped_item_params

    if @shipped_item.save
      @item.quantity -= @shipped_item.quantity
      @item.save
      redirect_to shipment_path(@shipment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @shipped_item.shipment.pending?
      @shipped_item.destroy
    else
      render 'items/edit', status: :unprocessable_entity
    end
  end

  private

  def shipped_items_params
    params.require(:shipped_item).permit(:shipment, :quantity, :item)
  end

  def set_shipped_item
    @shipped_item = ShippedItem.find(params[:id])
  end

  def new_shipped_item
    @shipped_item = ShippedItem.new
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_shipped_item_params
    #setting quantity
    @quantity = shipped_items_params[:quantity]
    @shipped_item.quantity = @quantity

    #setting item
    @item = Item.find(shipped_items_params[:item])
    @shipped_item.item = @item

    #setting shipment
    @shipment = Shipment.find(shipped_items_params[:shipment])
    @shipped_item.shipment = @shipment

    #setting shipped_item_item
    @item = Item.find(shipped_items_params[:item])
    @shipped_item.item = @item
  end
end
