class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :update]

  def index
    @shipments = Shipment.all
  end

  def create
    @shipment = Shipment.new

    if @shipment.save
      redirect_to shipments_path
    else
      render :shipments_path, status: :unprocessable_entity
    end
  end

  def show
    @shipped_items = @shipment.shipped_items
  end

  def update
    @shipment.status = 1
    if @shipment.save
      redirect_to shipment_path(@shipment)
    else
      render shipment_path(@shipment)
      render :edit, status: :unprocessable_entity

    end
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
