class ShipmentsController < ApplicationController
  before_action :set_shipment, only: %i[show update destroy]
  before_action :set_shipments, only: %i[index]

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

  def update
    if @shipment.shipped!
      redirect_to shipment_path(@shipment)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @shipment.pending?
      return_quantity
      @shipment.destroy
      redirect_to shipments_path
    else
      @shipment.errors.add :status, 'Cannot delete confirmed shipments'
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def set_shipments
    @shipments = Shipment.all
  end

  def return_quantity
    @shipment.shipped_items.each do |instance|
      instance.item.quantity += instance.quantity
      instance.item.save
    end
  end
end
