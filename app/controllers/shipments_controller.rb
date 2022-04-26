class ShipmentsController < ApplicationController
  before_action :set_shipment, only: %i[show update destroy edit]
  before_action :set_shipments, only: %i[index edit]

  def index; end

  def create
    @shipment = Shipment.new

    if @shipment.save
      redirect_to shipments_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @shipped_items = @shipment.shipped_items
  end

  def edit; end

  def update
    if @shipment.pending? && @shipment.shipped_items.present?
      @shipment.shipped!
      redirect_to edit_shipment_path(@shipment)
    else
      @shipment.errors.add :name, 'No items to ship or already shipped'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @shipment.pending?
      return_quantity
      @shipment.destroy
      redirect_to shipments_path
    else
      @shipment.errors.add :status, 'Cannot delete confirmed shipments'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def set_shipments
    @shipments = Shipment.all
  end

  def set_items
    @items = Items.all
  end

  def return_quantity
    @shipment.shipped_items.each do |instance|
      instance.item.quantity += instance.quantity
      instance.item.save
    end
  end
end
